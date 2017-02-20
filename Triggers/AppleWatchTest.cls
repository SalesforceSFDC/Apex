@isTest
private class AppleWatchTest {
	
	@isTest static void createOpportunity() {
			Opportunity opp = new Opportunity();
			opp.Name = 'Swift Deal';
			opp.StageName = 'Prospecting';
			opp.CloseDate = Date.today();
			
			insert opp;
	}
}
