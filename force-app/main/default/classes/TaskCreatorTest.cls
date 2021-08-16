@isTest
public with sharing class TaskCreatorTest {

    @TestSetup
    static void makeData(){
        Account account = new Account(Name='testTest');
        insert account;
    }

    @isTest
    public static void testCreateTask(){
        Account account = [SELECT Id, Name FROM Account WHERE Name='testTest'];
        System.assertEquals(1, [select Id from Task where WhatId=:account.Id].size());
    }
}