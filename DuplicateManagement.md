* see DuplicateError Class

response = cbsmssk1.SecureKey.call(
               cbsmssk1.SecureKey.Service.MONORAIL,
               cbsmssk1.SecureKey.httpVerb.GET,
               system.label.s_HMAC_Endpoint_Domain,
               system.label.s_HMAC_Endpoint_Search + key
           );

var myuuid = '3b241101-e2bb-4255-8caf-4136c566a962'

## RCA - Root Cause Ananlysis
In summary, root cause analysis (RCA, ili research spike) treba da nam da uvid na koji nacin kroz Monorail i TalkDesk new accounts i contacts kreiraju.  Na osnovu uvida moramo da zakljucimo zasto se u sistemu stvaraju duplicates.

Kada zavrsimo research spike, slijedeca user story trazi da merge duplicate contacts and accounts in production. Trenutno u sistemu ima preko 15,000 duplicates.

For additional context, TalkDesk je managed package koji su koristili za call center.  Taj call center je deprecated i ubuduce ce samo dozvoljavati korisnicama da loguju new cases via web form and email.

Monorail je ime koji su dali svome sistemu.`  Coinbase tech stack za web app je rails i react.  Plus, dodali su Snowflake za data warehouse.  Mi imamo integraciju izmedju Salesforce i Snowflake.  Npr., kada korisnik hoce da create new case, initate ce proces kroz web app ili mobile app.  Monorail ce da call Snowflake i da pass customer data to Salesforce.  U Salesforce pocinje case management i case disposition je synced into Snowflake.

Query method koji bi trebao da provjeri da li subject account ili contact postoji, neradi ili ga nema u sistemu.

# Setting DML Options
You can specify DML options for insert and update operations by setting the desired options in the `Database.DMLOptions` object.

You can set `Database.DMLOptions` for the operation by calling the setOptions method on the sObject, or by passing it as a parameter to the Database.insert and Database.update methods.

The Database.DMLOptions class has the following properties:
• allowFieldTruncationProperty
• assignmentRuleHeaderProperty
• dupicateRuleHeader
• emailHeaderProperty
• localeOptionsProperty
• optAllOrNoneProperty

DMLOptions settings take effect only for record operations performed using Apex DML and not through the Salesforce user interface.

## duplicateRuleheader Property
The `dupicateRuleHeader` property determines whether a record that’s identified as a duplicate can be saved. Duplicate rules are part of the Duplicate Management feature.

Using the dupicateRuleHeader property, you can set these options:
* `allowSave`: Indicates whether a record that’s identified as a duplicate can be saved.

The following example shows how to save an account record that’s been identified as a duplicate. To learn how to iterate through duplicate errors, see `DuplicateError` Class.
```java
Database.DMLOptions dml = new Database.DMLOptions();
dml.DuplicateRuleHeader.AllowSave = true;
Account duplicateAccount = new Account(Name='dupe');
Database.SaveResult sr = Database.insert(duplicateAccount, dml);
if (sr.isSuccess()) {
    System.debug('Duplicate account has been inserted in Salesforce!');
}
```

