public with sharing class AccountTriggerHandler {


	public static void createApplicationRecords(List<Account> triggerNew, Map<Id, Account> oldMap) {

		Id RECORDTYPE_1 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Institutional Entity Account').getRecordTypeId();
        Id RECORDTYPE_2 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Institutional Top Account').getRecordTypeId();
        
        List<Account> validAccounts = new List<Account>();
        List<Application__c> appList = new List<Application__c>();
        List<User> userList = new List<User>();
        Map<String, String> accIFIdMap = new Map<String,String>();
        Map<String, String> accContIdMap = new Map<String,String>();
        Set<Id> validAccIds = new Set<Id>();
        Set<String> fieldApis = new Set<String>();
        Set<Id> iFormIds = new Set<Id>();
        Set<Id> contactIds = new Set<Id>();
        Map<String,String> mdtMapping = new Map<String,String>();
        Map<String,Interest_Form__c> ifMap = new Map<String,Interest_Form__c>();
        Map<String, Contact> contactMap = new Map<String,Contact>();
        
        // Query Metadata
        List<Interest_Form_to_Application_Mapping__mdt> mdtList = [select Application_FIeld_API_Name__c, Interest_Form_Field_API_Name__c from Interest_Form_to_Application_Mapping__mdt];
        
        // Build Query String
        String query = '';

        query += 'SELECT ';

        for(Interest_Form_to_Application_Mapping__mdt mdt : mdtList){
        	mdtMapping.put(mdt.Interest_Form_Field_API_Name__c, mdt.Application_FIeld_API_Name__c);
        	fieldApis.add(mdt.Interest_Form_Field_API_Name__c);
        }

        fieldApis.add('Name_of_Firm__c');

        for(String s : fieldApis){
        	query += s+', ';
        }

        query += 'Id from Interest_Form__c where Id IN: iFormIds';

        system.debug('query ==> '+query);

        // Retrieve Valid Accounts
        for(Account acc : triggerNew){
        	if(acc.RecordTypeId == RECORDTYPE_1 || acc.RecordTypeId == RECORDTYPE_2){
        		Account oldAcc = oldMap.get(acc.Id);

				system.debug('acc.Application_Sent__c ==> ' + acc.Application_Sent__c);
				system.debug('oldAcc.Application_Sent__c ==> ' + oldAcc.Application_Sent__c);

        		if(acc.Application_Sent__c && !oldAcc.Application_Sent__c){
        			validAccounts.add(acc);
					validAccIds.add(acc.Id);
					iFormIds.add(acc.Interest_Form__c);
					accIFIdMap.put(acc.Id, acc.Interest_Form__c);
					contactIds.add(acc.Applying_Contact__c);
					accContIdMap.put(acc.Id, acc.Applying_Contact__c);
        		}
        	}
        }

		system.debug('validAccounts ==> ' + JSON.serialize(validAccounts));
        system.debug('iFormIds ==> ' + iFormIds);

        for(Interest_Form__c iForm : Database.query(query)){
        	ifMap.put(iForm.Id, iForm);
        }

        system.debug('ifMap ==> '+ifMap);

        //validAccounts = Database.query(query);
        for(Contact cont : [select Id, Email, FirstName, LastName from Contact where Id IN: contactIds]){
        	contactMap.put(cont.Id, cont);
        }

        Id profileId = [select Id from Profile where Name='Customer EBA Onboarding' limit 1].Id;

        // Create Application Records
        for(Account acc : validAccounts){

        	system.debug('accIFIdMap.get(acc.Id) ==> '+accIFIdMap.get(acc.Id));

    		Application__c app = new Application__c();
    		app.Applying_Account__c = acc.Id;
    		app.Applying_Contact__c = acc.Applying_Contact__c;

    		if(ifMap.containsKey(accIFIdMap.get(acc.Id))){
				Interest_Form__c iForm = ifMap.get(accIFIdMap.get(acc.Id));
        		system.debug('iForm ==> '+iForm);
        		app.Name = 'Prime Application: ' + iForm.get('Name_of_Firm__c');
	    		for(String s : mdtMapping.keySet()){
	    			String appField = mdtMapping.get(s);
	    			app.put(appField, iForm.get(s));
	    		}
        	} else{
        		app.Name = 'Prime Application: ' + acc.Name;
        	}
    		
    		appList.add(app);
    		system.debug('app ==> '+app);

    		// Create Community User
    		Contact thisContact = contactMap.get(accContIdMap.get(acc.Id));
		    string nick = thisContact.email!=null?thisContact.email.substring(0, thisContact.email.indexOf('@')):'';
		    nick = nick.left(20);
		    string alias = 'eba'+thisContact.email.left(5);
		    nick += Datetime.now().getTime();
		    
		    /*User newUser = new User(
		        alias = alias, 
		        email = thisContact.Email, 
		        emailencodingkey = 'UTF-8', 
		        firstname = thisContact.FirstName, 
		        lastname = thisContact.LastName, 
		        languagelocalekey = 'en_US', 
		        localesidkey = 'en_US', 
		        contactId = thisContact.Id,
		        timezonesidkey = 'Asia/Dubai', 
		        username = thisContact.email+'.coinbaseprime',
		        CommunityNickname = nick,
		        ProfileId = profileId,
		        IsActive = true);
		    userList.add(newUser);*/
        }

        system.debug('appList ==> ' + JSON.serialize(appList));

        if(appList.size() > 0){
        	try{
        		insert appList;
                /*if(userList.size() > 0){
                    try{
                        insert userList;
                    }catch(Exception e){
                        system.debug('Error inserting Community User record: '+e.getMessage());
                    }
                }*/
        	}catch(Exception e){
        		system.debug('Error inserting Application Records: '+e.getMessage());
        	}
        }
	}
	public static void isBeforeInsertAccount(List<Account> triggerNew){
		List<Account> accToEdit = new List<Account>();
        List<Account> accToHaveReferenceId = new List<Account>();
		for(Account ac : triggerNew){
			accToEdit.add(ac);
            //SSCM1-2948 Check to see if Account is being inserted with Reference Id (e.g Lead Conversion), if not, generate one
            if(String.isBlank(ac.Reference_ID__c)){
                accToHaveReferenceId.add(ac);
            }
		}
		insertHashedName(accToEdit);
        
        //SSCM1-2948 
        if(accToHaveReferenceId.size()>0) generateAndCheckExistingReferenceId(accToHaveReferenceId);
	}
	public static void isBeforeUpdateAccount(List<Account> triggerNew){
		List<Account> accToEdit = new List<Account>();
		for(Account ac : triggerNew){
			if(ac.HashedAccountName__c == null || String.isEmpty(ac.HashedAccountName__c)){
				accToEdit.add(ac);
			}
		}
		insertHashedName(accToEdit);
	}

	public static void insertHashedName(List<Account> accList){
        Blob salt = onb_LightningSelfRegisterController.Salt();
        for(Account acc : accList){
			Blob hashedAccNameDataBlob = crypto.generateMac('HmacSHA256', salt, Blob.valueOf((acc.Name).tolowerCase()));
			acc.HashedAccountName__c = EncodingUtil.base64Encode(hashedAccNameDataBlob);
		}
	}

    public static void generateAndCheckExistingReferenceId(List<Account> acc){
        Map<String,Account> refIdAccMap = new Map<String,Account>();
        for(Account a : acc){
            String reRefId = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(Math.abs(Crypto.getRandomLong())+String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'))))).substring(0,16);
            if(Test.isRunningTest()){
                reRefId = 'Ref123ID';
            }
            refIdAccMap.put(reRefId,a);
        }

        try{
            for(Lead ld : [SELECT Id, Reference_ID__c FROM Lead WHERE Reference_ID__c IN: refIdAccMap.KeySet()]){
                String reRefId = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(Math.abs(Crypto.getRandomLong())+String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'))))).substring(0,16);
                Account reAccount = refIdAccMap.get(ld.Reference_ID__c);
                refIdAccMap.remove(ld.Reference_ID__c);
                refIdAccMap.put(reRefId,reAccount);
            }
            insertReferenceId(refIdAccMap);
        }catch(Exception ex){
            System.debug('generateAndCheckExistingReferenceId Exception ' + ex.getLineNumber() + ' ' + ex.getMessage());
        }

    }

    public static void insertReferenceId(Map<String, Account> accMap){
        for(Account acc : [SELECT Reference_ID__c FROM Account WHERE Reference_ID__c IN: accMap.KeySet()]){
            String reRefId = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(Math.abs(Crypto.getRandomLong())+String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'))))).substring(0,16);
            Account reAccount = accMap.get(acc.Reference_ID__c);
            accMap.remove(acc.Reference_ID__c);
            accMap.put(reRefId,reAccount);
        }
        for(String refIds : accMap.KeySet()){
            try{
                accMap.get(refIds).Reference_ID__c = refIds;
            }catch(Exception ex){
                system.debug('insertReferenceId Exception ' + ex.getLineNumber() + ' ' + ex.getMessage());
            }
            
        }
    }
}