@isTest
public with sharing class AccountBatchWithoutTriggerTest {

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
                Is_Synced__c = false,
                MailingCity = 'Minsk'
            ));
        }

        insert contacts;
    }

    @isTest
    static void testBatch(){

        Test.startTest();
        AccountBatchWithoutTrigger accountBatchWithoutTrigger = new AccountBatchWithoutTrigger();
        Id batchId = Database.executeBatch(accountBatchWithoutTrigger);
        Test.stopTest();

        System.assertEquals(10, [SELECT Id FROM Contact WHERE MailingCity = 'testCity'].size());
        System.assertEquals(0, [SELECT Id FROM Contact WHERE MailingCity='Minsk'].size());
    }

}
