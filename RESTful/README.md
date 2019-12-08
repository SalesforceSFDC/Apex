## Key Aspects of being RESTful

In the RESTful world, operations are associated with a resource that is expressed via a `Uniform Resource Identifier (URI)`.
A resource can be a physical thing the application (i.e. Custom Field) or a conceptual thing.

* https://developer.salesforce.com/docs/api-explorer

### Mapping HTTP methods
* `GET` - This method is typically for operations that query the database and whose parameters are easily expressed in the URI structure and/or whose parameters fit well with this method.
* `PUT` vs `POST` - These methods are typically for operations that create, update or query the database and where parameters are more complex, for example, lists or structures of information that cannot be reflected in URI parameters.  And consideration around idempotency, whether or not request can be repeated over and over, resulting in the same state in the database.  
* `PATCH` - This method is typically for operations that solely update existing information, such as a record or some other complex dataset spanning multiple records.
* `DELETE` - to delete existing information expressed in the URI.
