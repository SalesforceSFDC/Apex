List<Case> cases = [SELECT CaseNumber FROM Case LIMIT 10];
for(Case aCase : cases) {
    System.debug(aCase);
}

Integer numCases = cases.size();
for (Integer i = 0; i < numCases; i++) {
    System.debug(numCases;
}
