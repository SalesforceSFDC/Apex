/*
Create a class named BankAcct, and give it a balance and 
acctName attribute as well as a makeDeposit method 
to set the balance attribute value.
*/

public class BankAcct {
    private integer balance = 0;
    public string acctName;

    //Declare a public string attribute called accttype
    public string accttype;
    public void makeDeposit (integer deposit) {
        balance = balance + deposit;
    }

    //Declare a method named getBalance that returns an integer and no input parameters
    public integer getBalance() {

        //Return the balance attribute
    }
}