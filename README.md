# Apex
Apex triggers, classes, web services,...

## Table of Contents

- [Packages](#packages)
	- [Lists](#lists)
	- [Maps](#maps)

## Packages

### Lists

### Maps

- [Maps](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_collections_maps.htm) 

A map is a collection of key-value pairs where each unique key maps to a single value.  Keys and values can be any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.

Map keys and values can contain any collection, and can contain nested collections.  Map keys can contain up to only four levels of nested collections.

To declare a map, use the Map keyword followed by the data types of the key and the value within <> characters. 
For example:

```Apex
Map<String, String> country_currencies = new Map<String, String>();
Map<ID, Set<String>> m = new Map<ID, Set<String>>();
```

As with lists, you can populate map key-value pairs when the map is declared by using curly brace ({}) syntax. Within the curly braces, specify the key first, then specify the value for that key using =>. 
For example:

```Apex
Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
```

To access elements in a map, use the Map methods provided by Apex. This example creates a map of integer keys and string values. It adds two entries, checks for the existence of the first key, retrieves the value for the second entry, and finally gets the set of all keys.

```Apex
Map<Integer, String> m = new Map<Integer, String>(); // Define a new map
m.put(1, 'First entry');                  // Insert a new key-value pair in the map
m.put(2, 'Second entry');                  // Insert a new key-value pair in the map
System.assert(m.containsKey(1));  // Assert that the map contains a key
String value = m.get(2);               // Retrieve a value, given a particular key
System.assertEquals('Second entry', value);
Set<Integer> s = m.keySet();       // Return a set that contains all of the keys in the map
```


