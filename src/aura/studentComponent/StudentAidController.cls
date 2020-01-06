public class StudentAidController {
	
    private final Student__c studentRecord;
    
    public StudentAidController(ApexPages.StandardController sc) {
        studentRecord = (Student__c)sc.getRecord();
    }
    
    public PageReference applyForAid() {
        studentRecord.appliedForFinancialAid__c = true;
        update studentRecord;
        return null;
    }
    
    @AuraEnabled
    public static Student__c getStudent(ID studentID) {
        if(studentId == null) return null;
        List<Student__c> students = [SELECT ID, appliedForFinancialAid__c
                                    	FROM Student__c
                                    	WHERE ID = :studentId];
        if(students.size() > 0) {
            return students[0];
        }
        return null;
    }
}