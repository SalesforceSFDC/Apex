public with sharing class {{ api_name }} {
    private static {{ api_name }} classInstance;

    static {
        classInstance = new {{ api_name }}();
    }

    private {{ api_name }}() {
        
    }

    public static {{ api_name }} getInstance() {
        return classInstance;
    }
}
