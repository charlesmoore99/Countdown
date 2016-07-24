/*
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package clocks.chat;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;

@ServerEndpoint(value = "/commChanel/{vewId}")
public class CommChannel {

	private static final Log log = LogFactory.getLog(CommChannel.class);

	private static final Set<CommChannel> connections = new CopyOnWriteArraySet<>();

	private Session session;

	public CommChannel() {
	}

	@OnOpen
	public void start(Session session, @PathParam("vewId") final String vewId) {
		session.getUserProperties().put("vewId", vewId);
		this.session = session;
		connections.add(this);
	}

	@OnClose
	public void end() {
		connections.remove(this);
	}

	@OnMessage
	public void incoming(String message) {
		String vewId = (String) session.getUserProperties().get("vewId");
		String filteredMessage = String.format("%s", message.toString());
		for (Session s : session.getOpenSessions()) {
			if (s.isOpen() && vewId.equals(s.getUserProperties().get("vewId"))) {
				broadcast(vewId, filteredMessage);
			}
		}

	}

	@OnError
	public void onError(Throwable t) throws Throwable {
		log.error("Chat Error: " + t.toString(), t);
	}

	private static void broadcast(String vewId, String msg) {
		for (CommChannel client : connections) {
			try {
				synchronized (client) {
					if (client.session.getUserProperties().get("vewId").equals(vewId))
						client.session.getBasicRemote().sendText(msg);
				}
			} catch (IOException e) {
				log.debug("Chat Error: Failed to send message to client", e);
				connections.remove(client);
				try {
					client.session.close();
				} catch (IOException e1) {
				}
			}
		}
	}
}