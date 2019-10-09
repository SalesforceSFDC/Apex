public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> acclist)
    {
        for(Account acc:acclist)
        {
            if(acc.ShippingState!=acc.BillingState)
            {
                acc.ShippingState = acc.BillingState;
            }
        }
    }
}
