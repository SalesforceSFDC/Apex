public with sharing class {{ api_name }} implements Iterable<{{ type_name }}> {

  public Iterator<{{ type_name }}> Iterator(){
    return new {{ iterator_class_name }}();
  }
  
}
