class BicycleDemo {
  public static void main(String[] args) {

      // Create two different
      // Bicycle objects
      Bicycle bike1 = new Bicycle();
      Bicycle bike2 = new Bicycle();

      // Invoke methods on those objects
      bike1.changeCadence(50);
      bike1.speedUp(10);
      bike1.changeGear(2);
      bike1.printStates();

      bike2.changeCadence(50);

  }
}

public class SomeClass
{
  private void someMethod(List<Id> recordIds) {
    List<Account> accounts = [Select Id, Name from Account Where Id IN :recordIds];
    // process account records to do awesome stuff
  }
}

public class NameClass
{
    public static List<Account> insertNewInvoice(date today)
    {
        List<Account> accounts = [Select Id, Name from Account Where Id IN :recordIds];
    }
}


public class InvoiceHandler
{
    public static List<APEX_Invoice__c> insertNewinvoice(date today)
    {
        List<APEX_Invoice__c> invoiceList = [SELECT id, Name, APEX_Status__c, createdDate FROM APEX_Invoice__c WHERE createdDate = today];

        return invoiceList;
    }
}

public class NameClass
{
    private Set<ID> contactids = new Set<ID>();
      for(Contact ct: cts) contactids.add(ct.id);
    {
        List<Task> tasks = [Select Id from Task Where Whoid IN :contactids LIMIT 500];
    }
}
