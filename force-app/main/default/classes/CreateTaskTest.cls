@isTest
public with sharing class CreateTaskTest {
    @isTest
    public static void testCreateTask(){
        Account acc = new Account(Name='testTest');
        insert acc;

        List<Id> listAcc = new List<Id>();
        listAcc.add(acc.Id);

        Test.startTest();
        CreateTask.createSyncTask(listAcc);
        Test.stopTest();

        System.assertEquals(acc.Id, [select WhatId from Task where WhatId=:acc.Id].get(0).WhatId);
    }
}
