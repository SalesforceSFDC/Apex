global class SomeClass {
  @future
  public static void someFutureMethod(List<Id> recordIds) {
    List<Account> accounts = [SELECT Id, Name, from Account Where Id IN :recordIds];
    // process account records
  }
}
