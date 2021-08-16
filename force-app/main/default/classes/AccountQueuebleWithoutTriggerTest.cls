@isTest
public with sharing class AccountQueuebleWithoutTriggerTest {

    @TestSetup
    static void makeData(){
        Account account = new Account(
            Name = 'testName',
            BillingCity = 'testCity'
        );
        
        insert account;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 10; i++) {
            contacts.add(new Contact(
                AccountId = account.Id,
                LastName = 'Contact' + i,
                MailingCity = 'Minsk'
            ));
        }

        insert contacts;
    }

    @isTest
    static void testQueueble(){
        Test.startTest();
        System.enqueueJob(new AccountQueuebleWithoutTrigger());
        Test.stopTest();

        System.assertEquals(10, [SELECT Is_Synced__c, Processed_By_Queue__c,
                                 Account.BillingCity FROM Contact WHERE Is_Synced__c = false AND
                                                                        Processed_By_Queue__c = true AND
                                                                        Account.BillingCity = 'testCity'].size());


        System.assertEquals(0, [SELECT Is_Synced__c, Processed_By_Queue__c,
                                Account.BillingCity FROM Contact WHERE Is_Synced__c = false AND
                                                                        Processed_By_Queue__c = false AND
                                                                        MailingCity = 'Minsk'].size());
    }


}




