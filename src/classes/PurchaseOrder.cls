public virtual class PurchaseOrder {

    Public class CustomerPurchaseOrder extends PurchaseOrder {

    }
    {
        List<PurchaseOrder> POs = new PurchaseOrder[] {};
        List<CustomerPurchaseOrder> CPOs = new CustomerPurchaseOrder[]{};
        POs = CPOs;
    }
}



public virtual class SubscriptionReparenting {

  Public class Subscription__c extends Account {

  }
  {
      List<Account> accts = new Account[] {};
      List<Susbcription__c> subs = new Subscription__c[]{};
      accts = subs;
  }
}

public class SubscriptionReparenting {
  public static void 
    Map<Integer, String> subscriptionid = new Map<Integer, String>();
    Map<ID, Account__c> m = new Map<ID, Account__c>();


}
