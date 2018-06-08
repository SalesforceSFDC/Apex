[SELECT Name, (SELECT LastName, FirstName FROM CONTACTS) FROM Account];

[SELECT Name, (SELECT Name, Duration__c FROM Courses__r) FROM Certification__c];

