trigger NonExistentId on Case (after insert) {
      for (Case myCase : Trigger.new) {
            CaseComment cc   = new CaseComment();
            cc.CommunityBody = 'Case received by Agent';
            cc.ParentId      = myCase.Id;
            insert cc;
      }
  }
