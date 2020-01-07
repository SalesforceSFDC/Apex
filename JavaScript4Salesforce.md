## JavaScript
```javascript
Object.defineProperties(
    j, {
        "firstName" : { value: "Jill", writable: true },
        "lastName" : { value: "GenericLastName", writable: true },
        "age" : { value: 35, writable: true },
        "GPA" : { valu: 3.8, writable: true },
        "appliedForFinancialAid" : { value: true }
    }
)
```

* JavaSript does not have classes but it has types.
* Each variable or piece of data is associated with a specific primitive or reference type.
* The five primitive types (strings, numbers, Booleans, null and undefined) represent simple values stored directly in the variable object for a given context.
* You can use `typeOf` to identify primitive types with the exception of the `null`.
* `null` must be compared directly against the special value null.
* Reference types are the closest thing to classes in JavaScript, and objects are instances of reference types. 
* You can create new objects using the new operator or a reference literal.
* You access properties and methods primarily using dot notation, but you can also use bracket nota- tion.
* Functions are objects in JavaScript, and you can identify them with the `typeof` operator.