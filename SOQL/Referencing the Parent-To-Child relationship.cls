// Standard relationship
[SELECT Name, (SELECT LastName, FirstName FROM CONTACTS) FROM Account];
// Custom relationship
[SELECT Name, (SELECT Name, Duration__c FROM Courses__r) FROM Certification__c];

