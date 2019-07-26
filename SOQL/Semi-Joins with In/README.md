# Semi-Joins with In
* Query values in a field where another field on the same object has a specified set of values, using IN.

```apex
SELECT Name FROM Account 
WHERE BillingState IN ('California', 'New York')
```

* Create more complex queries by replacing the list of values in the `IN` or `NOT IN` clause with a subquery.

* The subquery can reference by ID (primary key) or reference (foreign key) fields.

* A `semi-join` is a subquery on another object in an IN clause to restrict the records returned.

* An `anti-join` is a subquery on another object in a NOT IN clause to restrict the records returned.

### Sample uses of semi-joins and anti-joins include:
• Get all contacts for accounts that have an opportunity with a particular record type.
• Get all open opportunities for accounts that have active contracts.
• Get all open cases for contacts that are the decision maker on an opportunity.
• Get all accounts that do not have any open opportunities.

If you filter by an ID field, you can create parent-to-child semi- or anti-joins, such as Account to Contact. If you filter by a reference field, you can also create child-to-child semi- or anti-joins, such as Contact to Opportunity, or child-to-parent semi- or anti-joins, such as Opportunity to Account.

### ID field Semi-Join
The following query returns account IDs if an associated opportunity is lost:
```apex
SELECT Id, Name
FROM Account
WHERE Id IN 
    (
        SELECT AccountId
        FROM Opportunity 
        WHERE StageName = 'Closed Account'
    )
```

The following query returns task IDs for all contacts in Twin Falls:
```apex
SELECT Id
FROM Task
WHERE WhoId IN
(
    SELECT Id
    FROM CONTACT
    WHERE MailiingCity = 'Twin Falls'
)
```



