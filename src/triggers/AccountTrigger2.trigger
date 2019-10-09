trigger AccountTrigger on Account (before insert) 
{
    if (Trigger.isBefore && Trigger.isInsert) 
    {
            AccountTriggerHandler.CreateAccounts(Trigger.New);
    }   
}