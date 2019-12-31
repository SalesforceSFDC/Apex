trigger DedupeReminder on Account(after insert) {
      for(Account acc : Trigger.new) {
          Case c      = new Case();
          c.Subject   = 'Dedupe this Account';
          c.OwnerId   = '005F0000003vMsP';
          c.AccountId = acc.Id;
          insert c;
      }
  }
