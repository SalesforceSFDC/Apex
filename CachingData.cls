public class CachingData {
  private static Boolean IsUserSpecialChecked = false;
  private static Boolean UserIsSpecial = false;
  
  public static Boolean IsUserSpecial() {
    if(IsUserSpecialChecked) return UserIsSpecial;
      User u = [SELECT UserIsSpecial__c FROM User 
        WHERE Id = :UserInfo.getUserId()];  
  }
  
}
