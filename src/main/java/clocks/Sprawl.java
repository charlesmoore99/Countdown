package clocks;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.function.Consumer;

import com.orientechnologies.orient.core.sql.query.OSQLSynchQuery;
import com.orientechnologies.orient.object.db.OObjectDatabasePool;
import com.orientechnologies.orient.object.db.OObjectDatabaseTx;
import com.orientechnologies.orient.object.iterator.OObjectIteratorClass;


public class Sprawl {

//	static final String localdbstring = "plocal:c:\\work\\db\\thesprawl";
	static final String remotedbstring = "remote://127.8.198.130:2424/theSprawl";
//	static final String remotedbstring = "remote:localhost/theSprawl";
//	static final String dbUser = "mc";
//	static final String dbPassword = "Event-Strike-Special-Minute-9";
//	static final String dbUser = "root";
//	static final String dbPassword = "2B5192383BB0FDB80D82C1730A40EF3DAAAE3789B6C0C1CDBE9A5C9AE1A1C84C";
	static final String dbUser = "admin";
	static final String dbPassword = "admin";
	
	OObjectDatabaseTx odb;

	public Sprawl() {
		super();
		open();
	}
	
	public Sprawl(String db) {
		super();
		open(db);
	}
	
	public void open()  {
		odb = OObjectDatabasePool.global().acquire(Sprawl.remotedbstring, dbUser, dbPassword);
		odb.getEntityManager().registerEntityClasses("clocks");		
	}

	public void open(String db)  {
		odb = OObjectDatabasePool.global().acquire(db, dbUser, dbPassword);
		odb.getEntityManager().registerEntityClasses("clocks");
		
	}

	public void close(){
		odb.close();
	}

	public String createCampaign() {

		Campaign camp = odb.newInstance(Campaign.class);
		camp.setId(generateCampaignId());
		camp.setViewId(generateCampaignId());
		odb.save(camp);

		return camp.getId();
	}

	public void updateCampaign(String id, List<Clock> clocks) {
		Campaign camp = getCampaignById(id);
		camp.setClocks(clocks);
		odb.save(camp);
	}

	public void updateCampaign(String id, String name, List<Clock> clocks) {
		Campaign camp = getCampaignById(id);
		camp.setName(name);
		camp.setClocks(clocks);
		odb.save(camp);
	}

	public String generateCampaignId() {
		return UUID.randomUUID().toString();
	}

	public List<Campaign> getCampaigns() {
		List<Campaign> returnValue = new ArrayList<>();

		OObjectIteratorClass<Campaign> c = odb.browseClass(Campaign.class);
		c.forEach(new Consumer<Campaign>() {

			@Override
			public void accept(Campaign t) {
				returnValue.add(t);
			}
		});

		return returnValue;
	}

	public Campaign getCampaignById(String id) {
		List<Campaign> c = odb.query( new OSQLSynchQuery<Campaign>("select * from Campaign where id = '" + id + "'"));

		if (c.isEmpty())
			return null;
		else
			return c.get(0);
	}

	public Campaign getCampaignByViewId(String id) {
		List<Campaign> c = odb.query( new OSQLSynchQuery<Campaign>("select * from Campaign where viewId = '" + id + "'"));

		if (c.isEmpty())
			return null;
		else
			return c.get(0);
	}


	
	
//	
//	com.orientechnologies.orient.core.exception.ODatabaseException: Error on opening database 'remote:localhost/thesprawl'
//	at com.orientechnologies.orient.core.db.document.ODatabaseDocumentTx.<init>(ODatabaseDocumentTx.java:187)
//	at com.orientechnologies.orient.core.db.document.ODatabaseDocumentTx.<init>(ODatabaseDocumentTx.java:148)
//	at com.orientechnologies.orient.object.db.OObjectDatabaseTx.<init>(OObjectDatabaseTx.java:91)
//	at clocks.SprawlTest.createRemoteDb(SprawlTest.java:46)
//	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
//	at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
//	at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
//	at java.lang.reflect.Method.invoke(Unknown Source)
//	at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
//	at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
//	at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
//	at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
//	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:325)
//	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:78)
//	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:57)
//	at org.junit.runners.ParentRunner$3.run(ParentRunner.java:290)
//	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:71)
//	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:288)
//	at org.junit.runners.ParentRunner.access$000(ParentRunner.java:58)
//	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:268)
//	at org.junit.runners.ParentRunner.run(ParentRunner.java:363)
//	at org.eclipse.jdt.internal.junit4.runner.JUnit4TestReference.run(JUnit4TestReference.java:86)
//	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
//	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:459)
//	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:678)
//	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:382)
//	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:192)
//Caused by: com.orientechnologies.orient.core.exception.OConfigurationException: Error on opening database: the engine 'remote' was not found. URL was: remote:localhost/thesprawl. Registered engines are: [memory, plocal]
//	DB name="remote:localhost/thesprawl"
//	at com.orientechnologies.orient.core.Orient.loadStorage(Orient.java:476)
//	at com.orientechnologies.orient.core.db.document.ODatabaseDocumentTx.<init>(ODatabaseDocumentTx.java:167)
//	... 26 more
//
//
}
