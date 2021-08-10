public with sharing class AccountTriggerHandler {

    AccountTriggerHelper helper = new AccountTriggerHelper(Trigger.new, Trigger.old);

    public void onBeforeInsert(){
        //not implemented yet
    }
    public void onAfterInsert(List<Account> newAccounts){
        List<Id> listId = new List<Id>();
        for(Account acc : newAccounts){
            listId.add(acc.Id);
        }
        CreateTask.createSyncTask(listId);
    }
    public void onBeforeUpdate(){
        //not implemented yet
    }
    public void onAfterUpdate(){
        if (!System.isBatch()) {
            SynckedFieldsUtil util = new SynckedFieldsUtil(helper);
            System.enqueueJob(util);
            setSynckedFields(helper.returnChangedAccounts());
        }


        helper.assignTasks();
    }
    public void onBeforeDelete(){
        //not implemented yet
    }
    public void onAfterDelete(){
        //not implemented yet
    }
    public void onUndelete(){
        
    }
    @Future
    public static void setSynckedFields(Set<Id> accountIds){
        if (accountIds != null) {
            List<Account> listOfAccount = [select Id, 
            (Select Id, Is_Synced__c, Processed_By_Future__c from Contacts) 
            from Account where Id In :accountIds];
    
            List<Contact> contactsForUpdate = new List<Contact>();

            for(Account acc : listOfAccount){
                for(Contact con : acc.Contacts){
                    con.Is_Synced__c = false;
                    con.Processed_By_Future__c = true;
                    contactsForUpdate.add(con);
                }
            }
            System.debug(contactsForUpdate);
            update contactsForUpdate;
        }
    }
}