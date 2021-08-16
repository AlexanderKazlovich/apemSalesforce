public with sharing class TaskCreator {
    @Future
    public static void createSyncTask(List<Id> accountIds){
        System.debug(accountIds);
        if(accountIds != null){
            List<Task> newTasks = new List<Task>();
            for(Account account: [SELECT Id, Name FROM Account WHERE Id IN :accountIds]){
                System.debug(account);
            	Task newTask = new Task();
            	newTask.WhatId = account.Id;
                newTask.Subject = 'Negotiations with '+ account.Name;
                newTask.Is_Synced__c = false;
                newTasks.add(newTask);
            }

                insert newTasks;
        }
    }
}