public with sharing class CreateTask {
    @Future
    public static void createSyncTask(List<Id> accountIds){
        System.debug(accountIds);
        if(accountIds != null){
            List<Task> newTasks = new List<Task>();
            for(Account acc: [select Id, Name from Account where Id In :accountIds]){
                System.debug(acc);
            	Task newTask = new Task();
            	newTask.WhatId = acc.Id;
                newTask.Subject = 'Negotiations with '+ acc.Name;
                newTask.Is_Synced__c = false;
                newTasks.add(newTask);
            }
            System.debug(newTasks);
                insert newTasks;
        }
    }
}