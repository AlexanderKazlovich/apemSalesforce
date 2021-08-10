public with sharing class SynckedFieldsUtil implements Queueable {

    private AccountTriggerHelper helper;

    public SynckedFieldsUtil(AccountTriggerHelper helper){
        this.helper = helper;
    }

    public void execute(QueueableContext context){
        System.debug('inside execute' + helper);
        Set<Id> accountIds = helper.returnChangedAccounts();
        System.debug(accountIds);
        if (accountIds != null) {
            List<Account> listOfAccount = [select Id, 
            (Select Id, Is_Synced__c, Processed_By_Queue__c from Contacts) 
            from Account where Id In :accountIds];
    
            List<Contact> contactsForUpdate = new List<Contact>();

            for(Account acc : listOfAccount){
                for(Contact con : acc.Contacts){
                    con.Is_Synced__c = false;
                    con.Processed_By_Queue__c = true;
                    contactsForUpdate.add(con);
                }
            }
            System.debug(contactsForUpdate);
            update contactsForUpdate;
    }
}
}
