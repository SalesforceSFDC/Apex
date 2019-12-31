public class UpdateParentAccount implements Schedulable  {
    global void execute(SchedulableContext ctx)   {

      private List<Subscriptions__c> sub;
      private ID parent;

      public UpdateParentAccount(List<Subscription__c> records, ID id) {
          this.sub = records;
          this.parent = id;
    }

      public void execute(SchedulableContext ctx) {
          for (Subscription__c sub : subs) {
            sub.parentId = parent;
            // perform other processing or callout
          }
          update subs;
        }

    }
}
