@isTest
public with sharing class UpdateTasksTest {

    @TestSetup
    static void makeData(){
        Account account = new Account(Name='test');
        insert account;

        Task task = new Task(WhatId=account.Id, Is_Synced__c = false);
        insert task;
    }

    @isTest
    static void updateTasksBatchTest(){

        Test.startTest();
        Database.executeBatch(new UpdateTasks());
        Test.stopTest();

        System.assertEquals(1, [SELECT Id, (SELECT Id FROM Tasks WHERE Account_Owner__c='Alexander Kazlovich' AND Is_Synced__c = true)
                                FROM Account WHERE  Updated_By_Task__c = true].size());
    }


}
