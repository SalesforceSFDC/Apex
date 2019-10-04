Map<ID, Contact> contactmap = new Map<ID, Contact>(cts);

List<Task> task2 = [SELECT ID FROM Task WHERE Whoid in :contactmap.keyset() LIMIT 500];
