package clocks;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.sql.SQLException;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Predicate;

import org.junit.Ignore;
import org.junit.Test;

public class SprawlTest {
	// public static String dbString = "memory:thesprawl";
	// public static final String dbString = "plocal:thesprawl";
	String db = "remote:127.8.198.130/theSprawl";
	// @BeforeClass
	// public static void before() {
	// try {
	// OObjectDatabaseTx o = new OObjectDatabaseTx(dbString);
	// o.create();
	// o.close();
	// } catch (Throwable t) {
	// }
	// }
	//
	// @AfterClass
	// public static void after() {
	// // new OObjectDatabaseTx(dbString)
	// }
	//

	// @Ignore
	// @Test
	// public void createLocalDb() {
	// OObjectDatabaseTx db = new OObjectDatabaseTx(Sprawl.localdbstring);
	// db.create();
	// db.close();
	//
	// }

	@Ignore
	@Test
	public void createRemoteDb() {
		// OObjectDatabaseTx db = new OObjectDatabaseTx(Sprawl.remotedbstring);
		// db.create();
		// db.close();
		//
	}

	@Ignore
	@Test
	public void openRemoteDb() {
		// OObjectDatabaseTx db = new OObjectDatabaseTx(Sprawl.remotedbstring);
		// db.open(Sprawl.dbUser, Sprawl.dbPassword);
		// db.close();
		//
	}

	// @Test
	// public void createMemoryDb() {
	// OObjectDatabaseTx db = new OObjectDatabaseTx(dbString);
	// db.open("admin", "admin");
	//
	// db.getEntityManager().registerEntityClasses("clocks");
	//
	// Clock legwork = new Clock("Legwork", "The Legwork Clock", 0);
	// Clock action = new Clock("Action", "The Action Clock", 0);
	//
	// // CREATE A NEW PROXIED OBJECT AND FILL IT
	// Campaign camp = db.newInstance(Campaign.class);
	// camp.setName("The Campaign");
	// camp.setDescription("A Description");
	// camp.getClocks().add(legwork);
	// camp.getClocks().add(action);
	// db.save(camp);
	// db.close();
	//
	// // get it back out
	// OObjectDatabaseTx db2 = new OObjectDatabaseTx(dbString);
	// db2.open("admin", "admin");
	// db2.getEntityManager().registerEntityClasses("clocks");
	//
	// Campaign c = db2.browseClass(Campaign.class).next();
	// assertEquals("The Campaign", c.getName());
	// db2.close();
	// }
	//
	
	@Test
	public void create1() {
		Sprawl s = new Sprawl();

		try {
			String id = s.createCampaign();

			List<Campaign> camps = s.getCampaigns();

			assertNotEquals(0, camps.size());

			camps.forEach(new Consumer<Campaign>() {

				@Override
				public void accept(Campaign t) {
					System.out.println(t);

				}
			});

			boolean foundit = camps.stream().anyMatch(new Predicate<Campaign>() {
				@Override
				public boolean test(Campaign t) {
					return t.getId().equals(id);
				}
			});
			assertTrue(foundit);
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}

	@Ignore
	@Test
	public void create2() {
		Sprawl s = new Sprawl();

		String id = null;
		try {
			id = s.createCampaign();
		} catch (SQLException e) {
			fail(e.getMessage());
		}

		Campaign camp = s.getCampaignById(id);

		assertNotNull(camp);

	}

	@Test
	public void create3() {
		Sprawl s = new Sprawl();

		String id = null;
		try {
			id = s.createCampaign();
		} catch (SQLException e) {
			e.printStackTrace();
			fail(e.getMessage());
		}

		Campaign camp = s.getCampaignById(id);
		assertNotNull(camp);

		camp.addClock(new Clock("one", 1));
		try {
			s.save(camp);
		} catch (SQLException e) {
			e.printStackTrace();
			fail("SQL Exception");
		}

		Campaign camp2 = s.getCampaignById(id);
		System.out.println(camp2);
		
	}


	
	@Test
	public void listAll() {
		Sprawl s = new Sprawl();

		for (Campaign cur : s.getCampaigns()) {
			System.out.println(cur.toString());
		}
	}
}
