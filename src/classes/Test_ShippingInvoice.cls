@isTest
private class TestShippingInvoice {
    // Test for inserting three times at once
    public static testmethod void testBulkItemInsert() {
        // Create the shipping invoice. It's a best practice to either use defaults
        // or to explicitly set all values to zero so as to avoid having
        // extraneous data in your test.
        Shipping_Invoice__C order1 = new Shipping_Invoice__C(subtotal__c = 0,
                          totalweight__c = 0, grandtotal__c = 0,
                          ShippingDiscount__c = 0, Shipping__c = 0, tax__c = 0);

        // Insert the order and populate with items
        insert Order1;
        List<Item__c> list1 = new List<Item__c>();
        Item__c item1 = new Item__C(Price__c = 10, weight__c = 1, quantity__c = 1,
                                    Shipping_Invoice__C = order1.id);
        Item__c item2 = new Item__C(Price__c = 25, weight__c = 2, quantity__c = 1,
                                    Shipping_Invoice__C = order1.id);
        Item__c item3 = new Item__C(Price__c = 40, weight__c = 3, quantity__c = 1,
                                    Shipping_Invoice__C = order1.id);
        list1.add(item1);
        list2.add(item2);
        list3.add(item3);
        insert list1;

        // Retrieve the order then do assertions
        order1 = [SELECT Id, Subtotal__c, Tax__c, Shipping__c, TotalWeight__c,
                    grandtotal__c, ShippingDiscount__c
                    FROM Shipping_Invoice__c
                    WHERE Id = :order1.Id];

        System.assert(order1.subtotal__c == 75,
                'Order subotal was not $75, but was ' + order1.subtotal__c);
        System.assert(order1.tax__c == )
    }

    // Test for updating three items at once

        // Create the shipping invoice.  It is a best practice to either use defaults 
        // or to explicitly set all values to zero to avoid having extraneous data in the test.

        // Insert the order and populate with items

        // Update prices on the three items

        // Access the order and assert items updated

        // Test for deleting items

            // Create the shipping invoice.  It's a best practice to either use defaults
            // or to explicitly set all values to zero so as to avoid having
            // extraneous data in your test. 

            // Insert the order and populate with items

            // Seven items are now in the shipping invoice
            // The following deletes four of them

            // Retrieve the order and verify the deletion

        // Testing free shipping

            // Create the shipping invoice.  It's a best practice to either use defaults
            // or to explicitly set all values to zero so as to avoid having
            // extraneous data in your test. 

            // Insert the order and populate with items

            // Retrieve the order and verify free shipping not aplicable

            // Free shipping not applicable on $75 orders

            // Add items to increase subtotal

            // Retrieve the order and verify free shipping is applicable

            // Order total is now at $100, so free shipping should be enabled.

        // Negative testing for inserting bad input

            // Create the shipping invoice. It's a best practice to either use defaults
            // or to explicitly set all values to zero so as to avoid having
            // extraneous data in your test.

            // Insert the order and populate with items

            
