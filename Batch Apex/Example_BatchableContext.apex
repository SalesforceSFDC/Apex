global void finish (Database.BatchableContext BC) {
  // Get the ID of the AsyncApexJob representing this batch job from Database.BatchableContext.
  // Query the AyncApexJob object to retrieve the current job's information
  AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Emailv
}
