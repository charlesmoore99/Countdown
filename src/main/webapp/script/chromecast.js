

//var applicationID = '4313056E';
var applicationID = 'A28B2CFD';
//var applicationID = '794B7BBF';
var namespace = 'urn:x-cast:com.google.cast.sample.helloworld';
var session = null;

var receiversAvailable = false;

/**
 * Call initialization for Cast
 */
if (!chrome.cast || !chrome.cast.isAvailable) {
  setTimeout(initializeCastApi, 1000);
}

/**
 * initialization
 */
function initializeCastApi() {
  var sessionRequest = new chrome.cast.SessionRequest(applicationID);
  var apiConfig = new chrome.cast.ApiConfig(sessionRequest,
    sessionListener,
    receiverListener);

  chrome.cast.initialize(apiConfig, onInitSuccess, onError);
};

/**
 * initialization success callback
 */
function onInitSuccess() {
  appendMessage("onInitSuccess");
}

/**
 * initialization error callback
 */
function onError(message) {
  appendMessage("onError: "+JSON.stringify(message));
}

/**
 * generic success callback
 */
function onSuccess(message) {
  appendMessage("onSuccess: "+message);
}

/**
 * callback on success for stopping app
 */
function onStopAppSuccess() {
  appendMessage('onStopAppSuccess');
  session = null;
  showIdleChromecast();
}

/**
 * session listener during initialization
 */
function sessionListener(e) {
  appendMessage('New session ID:' + e.sessionId);
  session = e;
  session.addUpdateListener(sessionUpdateListener);  
  session.addMessageListener(namespace, receiverMessage);
  
  // send the intial data packet
  sendMessage( ko.toJSON(sprawl.clocks))
}

/**
 * listener for session updates
 */
function sessionUpdateListener(isAlive) {
  var message = isAlive ? 'Session Updated' : 'Session Removed';
  message += ': ' + session.sessionId;
  appendMessage(message);
  if (!isAlive) {
    session = null;
  }
};

/**
 * utility function to log messages from the receiver
 * @param {string} namespace The namespace of the message
 * @param {string} message A message string
 */
function receiverMessage(namespace, message) {
  appendMessage("receiverMessage: "+namespace+", "+message);
};

/**
 * receiver listener during initialization
 */
function receiverListener(e) {
  if( e === 'available' ) {
    appendMessage("receiver found");
    receiversAvailable = true;
    showIdleChromecast();
  }
  else {
    appendMessage("receiver list empty");
  }
}

/**
 * stop app/session
 */
function stopApp() {
  session.stop(onStopAppSuccess, onError);
}

function startSession(message) {
    chrome.cast.requestSession(function(e) {
        session = e;
        session.sendMessage(namespace, message, onSuccess.bind(this, "Message sent: " + message), onError);
        showActiveChromecast()
      }, onError);
};


/**
 * send a message to the receiver using the custom namespace
 * receiver CastMessageBus message handler will be invoked
 * @param {string} message A message string
 */
function sendMessage(message) {
  if (session!=null) {
    session.sendMessage(namespace, message, onSuccess.bind(this, "Message sent: " + message), onError);
  }
//  else {
//    chrome.cast.requestSession(function(e) {
//        session = e;
//        session.sendMessage(namespace, message, onSuccess.bind(this, "Message sent: " + message), onError);
//        showActiveChromecast()
//      }, onError);
//  }
}

/**
 * append message to debug message window
 * @param {string} message A message string
 */
function appendMessage(message) {
  console.log(message);
//  var dw = document.getElementById("debugmessage");
//  dw.innerHTML += '\n' + JSON.stringify(message) + "<br>";
};

