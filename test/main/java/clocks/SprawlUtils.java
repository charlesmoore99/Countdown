package clocks;

import org.junit.Ignore;
import org.junit.Test;

public class SprawlUtils {
	String db = "remote://LOCALHOST:2424/theSprawl";

	@Test
	public void listAll() {
		Sprawl s = new Sprawl(db);
		
		for (Campaign cur : s.getCampaigns()){
			System.out.println(cur.getName() + " :: " + cur.getClocks().size());
		}
		s.close();
	}

	@Ignore
	@Test
	public void fixEnptyNames() {
		Sprawl s = new Sprawl(db);
		
		for (Campaign cur : s.getCampaigns()){
			if (cur.getName() ==null || cur.getName().isEmpty()) {
				System.out.println(cur.getId() + " :: " + cur.getClocks().size());
				s.updateCampaign(cur.getId(), "The Big Board", cur.getClocks());
			}
		}
		s.close();
	}
}


