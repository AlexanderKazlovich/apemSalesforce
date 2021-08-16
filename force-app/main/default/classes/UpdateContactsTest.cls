@isTest
public with sharing class UpdateContactsTest {

    @TestSetup
    static void makeData(){
        Account account = new Account(Name ='test', BillingCity='Minsk');
        insert account;

        Contact contact = new Contact(LastName='testContact', AccountId=account.Id, Is_Synced__c= false);
        insert contact;
    }

    @isTest
    static void updateContactsBatchTest(){

        Test.startTest();
        Database.executeBatch(new UpdateContacts());
        Test.stopTest();

        System.assertEquals(1, [SELECT Id,(SELECT LastName FROM Contacts WHERE MailingCity = 'Minsk' AND Is_Synced__c = true) 
                                FROM Account WHERE Updated_By_Contact__c = true].size() );

    }

}
