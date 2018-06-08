Set<String> caseSet = new Set<String>{'000001', '00002'};
List<Case> selectCases = [SELECT CaseNumber 
                          FROM Case
                          WHERE CaseNumber IN :caseSet];
