public with sharing class UpdateTasks implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name, Updated_By_Task__c, (SELECT Account.Owner.Name, Account_Owner__c, Is_Synced__c FROM Tasks WHERE Is_Synced__c = false) FROM Account');
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){  
    
        List<Task> tasksForUpdate = new List<Task>();
        for(Account account : scope){
            if (account.Tasks.size() != 0) {
                for(Task task : account.Tasks){
                    task.Account_Owner__c = task.Account.Owner.Name;
                    task.Is_Synced__c = true;
                    tasksForUpdate.add(task);

                    
                }
                account.Updated_By_Task__c = true;
            }
        }

        update scope;
        update tasksForUpdate;
    }

    public void finish(Database.BatchableContext bc){
        //not implemented yet
    }
}
