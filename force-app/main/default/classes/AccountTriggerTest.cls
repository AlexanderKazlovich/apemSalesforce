@isTest
public with sharing class AccountTriggerTest {


    @isTest
    static void onInsertTest(){
        Account account = [SELECT Id FROM Account WHERE Name='test'];

        System.assertEquals(1, [SELECT Id FROM Task WHERE 
                            Subject='Negotiations with test' AND
                            WhatId = :account.Id AND
                            Is_Synced__c = false].size());
    }
    
    
    
    @TestSetup
    static void makeData(){
        Account account = new Account(Name='test', BillingCity='Grodno');
        insert account;
        Contact contact = new Contact(LastName='testContact', AccountId = account.Id);
        insert contact;

        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < 4; i++) {
            Task task = new Task();
            task.WhatId=account.id;
            tasks.add(task);
        }
        insert tasks;
    }

    @isTest
    static void onUpdateTest(){
        //test Queueble

        Account acc = [SELECT Id, BillingCity FROM Account where Name ='test' limit 1];

        acc.BillingCity = 'Minsk';
 
        Test.startTest();
        Database.SaveResult result = Database.update(acc);
        Test.stopTest();
        System.assertEquals(1, [SELECT Id FROM Contact WHERE AccountId = :acc.Id AND Is_Synced__c = false AND Processed_By_Queue__c = true ].size());
        System.assertEquals(5, [SELECT Id FROM Task WHERE WhatId= :acc.id AND task.OwnerId = '0055g00000Bn4IIAAZ'].size());
    
    
    }


}
