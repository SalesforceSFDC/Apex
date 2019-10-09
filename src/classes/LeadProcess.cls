global class LeadProcessor implements    Database.Batchable<Sobject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([Select LeadSource From Lead ]);
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
            for (Lead Leads : scope) {
                Leads.LeadSource = 'Dreamforce';
            }
        update scope;
    }    

    global void finish(Database.BatchableContext bc){   }    
}