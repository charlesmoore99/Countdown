package clocks;

import java.sql.SQLException;

import org.junit.Ignore;
import org.junit.Test;

public class SprawlUtils {
	String db = "remote://LOCALHOST:2424/theSprawl";

	@Test
	public void listAll() {
		Sprawl s = new Sprawl("localhost", "5432");
		
		int x = 0;
		for (Campaign cur : s.getCampaigns()){
			System.out.println(x++ + "::" + cur.getName() + " :: " + cur.getClocks().size() + " :: " + cur.getLastUpdated());
		}
	}

	@Ignore
	@Test
	public void fixEnptyNames() throws SQLException {
		Sprawl s = new Sprawl("localhost", "5432");
		
		for (Campaign cur : s.getCampaigns()){
			if (cur.getName() ==null || cur.getName().isEmpty()) {
				System.out.println(cur.getId() + " :: " + cur.getClocks().size());
				s.updateCampaign(cur.getId(), "The Big Board", cur.getClocks());
			}
		}
	}
	
	
//	@Test
//	public void createCamp() throws InterruptedException {
//		Sprawl s = new Sprawl(db);
//
//		String id = s.createCampaign();
//		
//		Campaign cur = s.getCampaignById(id);
//		System.out.println(cur.getName() + " :: " + cur.getClocks().size() + " :: " + cur.getLastUpdated());
//
//Thread.sleep(2000);
//		
//		s.updateCampaign(id, "BIG BOBS USED CARPET", cur.getClocks());
//		
//		Campaign cur2 = s.getCampaignById(id);
//		System.out.println(cur2.getName() + " :: " + cur2.getClocks().size() + " :: " + cur2.getLastUpdated());
//		
//				
//		
//	}
}


