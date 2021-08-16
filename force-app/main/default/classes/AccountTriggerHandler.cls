public with sharing class AccountTriggerHandler {

    private static boolean isFirstRun = true;
    
    AccountTriggerHelper helper = new AccountTriggerHelper(Trigger.old, Trigger.new);

    public void onBeforeInsert(){
        if (isFirstRun) {
            isFirstRun = false;
            //not implemented yet
        }
    }
    public void onAfterInsert(){
        if (true) {
            isFirstRun = false;
            TaskCreator.createSyncTask(helper.getIdsFromTriggerNew());           
        }
    }
    public void onBeforeUpdate(){
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }
    public void onAfterUpdate(){
        if (true) {
            isFirstRun = false;
                if (!System.isBatch()) {
                SynckedFieldsUtil util = new SynckedFieldsUtil(helper);
                System.enqueueJob(util);
                setSynckedFields(helper.returnChangedAccounts());
                }

            helper.assignTasks(); 
        }
    }
    public void onBeforeDelete(){
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }
    public void onAfterDelete(){
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }
    public void onUndelete(){
        if(isFirstRun){
            isFirstRun = false;
            //not implemented yet
        }
    }
    @Future
    public static void setSynckedFields(Set<Id> accountIds){
        if (accountIds != null) {
            List<Account> listOfAccount = [SELECT Id, 
            (SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contacts) 
            FROM Account WHERE Id IN :accountIds];
    
            List<Contact> contactsForUpdate = new List<Contact>();

            for(Account account : listOfAccount){
                for(Contact contact : account.Contacts){
                    contact.Is_Synced__c = false;
                    contact.Processed_By_Future__c = true;
                    contactsForUpdate.add(contact);
                }
            }

            update contactsForUpdate;
        }
    }
}