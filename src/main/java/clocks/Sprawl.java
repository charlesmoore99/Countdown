package clocks;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import com.google.gson.Gson;
import com.jcabi.aspects.Cacheable;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.Outcome;
import com.jcabi.jdbc.SingleOutcome;
import com.jcabi.jdbc.Utc;
import com.jolbox.bonecp.BoneCPDataSource;

public class Sprawl {

	// static final String localdbstring = "plocal:c:\\work\\db\\thesprawl";
	// static final String remotedbstring =
	// "remote://127.8.198.130:2424/theSprawl";
	static final String remotedbstring = "remote://127.0.0.1:5432/clocks";
	// static final String remotedbstring = "remote:localhost/theSprawl";
	// static final String dbUser = "mc";
	// static final String dbPassword = "Event-Strike-Special-Minute-9";
	// static final String dbUser = "root";
	// static final String dbPassword =
	// "2B5192383BB0FDB80D82C1730A40EF3DAAAE3789B6C0C1CDBE9A5C9AE1A1C84C";
	static final String dbUser = "clocks";
	static final String dbPassword = "clocks";

	static BoneCPDataSource source = null;
	
//	@Cacheable(forever = true)
//	private static DataSource source() {
//	}

	public Sprawl() {
		super();
		if (source == null) {
			source = new BoneCPDataSource();
			source.setDriverClass("org.postgresql.Driver");
			source.setJdbcUrl("jdbc:postgresql://localhost:5432/clocks");
			source.setUser("clocks");
			source.setPassword("clocks");
		}
	}

	public Sprawl(String host, String port) {
		super();
		if (source == null) {
			source = new BoneCPDataSource();
			source.setDriverClass("org.postgresql.Driver");
			source.setJdbcUrl("jdbc:postgresql://" + host + ":" + port +"/clocks");
			source.setUser("clocks");
			source.setPassword("clocks");
		}
	}

	public String createCampaign() throws SQLException {

		Campaign camp = new Campaign();
		camp.setName("The Big Board");
		camp.setId(generateCampaignId());
		camp.setViewId(generateCampaignId());
		camp.setLastUpdated();

		save(camp);

		return camp.getId();
	}

	public void updateCampaign(String id, List<Clock> clocks) throws SQLException {
		Campaign camp = getCampaignById(id);
		camp.setClocks(clocks);
		camp.setLastUpdated();
		save(camp);
	}

	public void updateCampaign(String id, String name, List<Clock> clocks) throws SQLException {
		Campaign camp = getCampaignById(id);
		camp.setName(name);
		camp.setClocks(clocks);
		camp.setLastUpdated();
		save(camp);
	}

	public String generateCampaignId() {
		return UUID.randomUUID().toString();
	}

	public List<Campaign> getCampaigns() {
		List<Campaign> returnValue = new ArrayList<>();
		try {
			returnValue.addAll(
					new JdbcSession(source).sql("SELECT * FROM campaign").select(new Outcome<List<Campaign>>() {
						@Override
						public List<Campaign> handle(ResultSet rset, Statement arg1) throws SQLException {
							final List<Campaign> ccc = new ArrayList<>();
							while (rset.next()) {
								Campaign c = new Campaign();
								c.setId(rset.getString("id"));
								c.setViewId(rset.getString("view"));
								Date ddd = rset.getTimestamp("lastupdated");
								c.setLastUpdated(ddd);
								c.setName(rset.getString("name"));

								Gson g = new Gson();
								Clock[] clockArray = g.fromJson(rset.getString("clocks"), Clock[].class);
								c.addClocks(Arrays.asList(clockArray));
								ccc.add(c);
							}
							return ccc;
						}
					}));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return returnValue;
	}

	public Campaign getCampaignById(String id) {
		try {
			Campaign camp = new JdbcSession(source)
					.sql("SELECT * FROM campaign WHERE id like ?").set(id)
					.select(new Outcome<Campaign>() {
						@Override
						public Campaign handle(ResultSet rset, Statement arg1) throws SQLException {
							final Campaign c = new Campaign();
							while (rset.next()) {
								c.setId(rset.getString("id"));
								c.setViewId(rset.getString("view"));
								Date ddd = rset.getTimestamp("lastupdated");
								c.setLastUpdated(ddd);
								c.setName(rset.getString("name"));
								Gson g = new Gson();
								Clock[] clockArray = g.fromJson(rset.getString("clocks"), Clock[].class);
								c.addClocks(Arrays.asList(clockArray));
							}
							return c;
						}
					});
			return camp;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public Campaign getCampaignByViewId(String id) {
		try {
			Campaign camp = new JdbcSession(source)
					.sql("SELECT * FROM campaign WHERE view like ?").set(id)
					.select(new Outcome<Campaign>() {
						@Override
						public Campaign handle(ResultSet rset, Statement arg1) throws SQLException {
							final Campaign c = new Campaign();
							while (rset.next()) {
								c.setId(rset.getString("id"));
								c.setViewId(rset.getString("view"));
								Date ddd = rset.getTimestamp("lastupdated");
								c.setLastUpdated(ddd);
								c.setName(rset.getString("name"));
								Gson g = new Gson();
								Clock[] clockArray = g.fromJson(rset.getString("clocks"), Clock[].class);
								c.addClocks(Arrays.asList(clockArray));
							}
							return c;
						}
					});
			return camp;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// saves the campaign to the database
	void save(Campaign c) throws SQLException {
		String clocksJson = c.getClocksJson();
		Campaign existing = getCampaignById(c.getId());
		if (existing != null && !existing.getId().isEmpty()) {
			new JdbcSession(source).sql("update campaign SET name = ?, clocks = ?, lastupdated = ? where id = ?")
					.set(c.getName()).set(clocksJson).set(new Utc()).set(c.getId()).update(Outcome.VOID);
		} else {
			new JdbcSession(source).sql("INSERT INTO campaign (id, view, name, clocks) VALUES (?, ?, ?, ?)")
					.set(c.getId()).set(c.getViewId()).set(c.getName()).set(clocksJson)
					.update(new SingleOutcome<String>(String.class));
		}
	}
}