# Web Services

## Expose a Class as a REST Service
1. Define class as `global`
2. Define methods as `static`
3. Add annotations to the class and methods.
4. The URL mapping is case-sensitive and can contain a wildcard character (*).
5. Define each exposed method as global static and add an annotation to associate it with an HTTP method.
6. You can use each annotation only once in each Apex class.
7. Version your API endpoints so that you can provide upgrades in functionality without breaking existing code.

