//
public class AcceptCaseController {
	@AuraEnabled
    public static void updateStatus(case obj,String oId){
        system.debug('obj' + obj);
        case cc = obj;
        cc.Id = oId;
        update cc;
    }
    @AuraEnabled
    public static currentOwner validateCurrentOwner(String oId){
        Case c = [select OwnerId, Owner.Name from Case where Id=: oId];
        if(String.valueOf(c.OwnerId).startsWith('005')){
        	return new currentOwner(true, c.Owner.Name);    
        }
        else{
        	return new currentOwner(false,'');            
        }
    }
    public class currentOwner{
        @AuraEnabled
        public Boolean ownerIsUser {get;set;}
        @AuraEnabled
        public String currentOwnerName {get;set;}
        public currentOwner(Boolean ownerIsUser, String currentOwnerName){
            this.ownerIsUser = ownerIsUser;
            this.currentOwnerName = currentOwnerName;
        }
    }
}