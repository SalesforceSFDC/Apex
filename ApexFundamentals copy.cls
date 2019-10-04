Integer NUM = 10;

accs = new Account[10];
For (Integer I = 0; I < NUM; I++) { //control structure
  accs[I] = new Account(name='test ' + I,
    outstandingshare__c = I);
}
insert accs;

Contact[] cons = new Contact[0]; //array (List)
For (Account acc : accs) {
  cons.add(new Contact(lastName = acc.nam + '1',
    accountid = acc.id));
  cons.add(new Contact(lastName = acc.nam + '2'));
}
insert cons; //data (DML) operation
