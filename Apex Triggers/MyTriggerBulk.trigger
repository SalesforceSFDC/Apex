trigger MyTriggerBulk on Account (before insert) {
  for (Account a : Trigger.New) {
    a.Description = 'New description';
  }
}
