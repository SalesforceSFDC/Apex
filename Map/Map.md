# Map
* A map is a collection of key-value pairs where each unique key maps to a single value. Keys and values can be any data type—primitive types, collections, sObjects, user-defined types, and built-in Apex types.
* Map keys and values can contain any collection, and can contain nested collections.
* Map keys can contain up to only four levels of nested collections.
* To access elements in a map, use the Map methods provided by Apex.
* `Map<Key, Value>`
* Apex uses hash structure for all of the Maps

## Example 1
This example creates a map of integer keys and string values. It adds two entries, checks for the existence of the first key, retrieves the value for the second entry, and finally gets the set of all keys.
```Apex
Map<Integer, String> m = new Map<Integer, String>(); // Define a new map
m.put(1, 'First Entry'); // Insert a new key-value pair in the map
m.put(2, 'Second Entry'); // Insert the key-value pair in the map
System.assert(m.containsKey(1)); // Assert that the map contains a key
String value = m.get(2); // Retrieve a particular key
System.assertEquals('Second Entry', value);
Set<Integer> s = m.keySet(); // Return a set that contains all of the keys in the map
```
## Map Methods
* put
* get
* containsKey
* remove
