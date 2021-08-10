public with sharing class UpdateTasks implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select Id, Name, Updated_By_Task__c, (Select Account.Owner.Name, Account_Owner__c, Is_Synced__c from Tasks where Is_Synced__c = false) from Account');
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){  
   
        List<Task> tasksForUpdate = new List<Task>();
        for(Account acc : scope){
            if (acc.Tasks.size() != 0) {
                for(Task t : acc.Tasks){
                    t.Account_Owner__c = t.Account.Owner.Name;
                    t.Is_Synced__c = true;
                    tasksForUpdate.add(t);
                }
                acc.Updated_By_Task__c = true;
            }
        }

        update scope;
        update tasksForUpdate;
    }

    public void finish(Database.BatchableContext bc){
        //not implemented yet
    }
}
