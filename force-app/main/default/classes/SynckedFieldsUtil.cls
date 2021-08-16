public with sharing class SynckedFieldsUtil implements Queueable {

    private AccountTriggerHelper helper;

    public SynckedFieldsUtil(AccountTriggerHelper helper){
        this.helper = helper;
    }

    public void execute(QueueableContext context){
        System.debug('inside execute' + helper);
        Set<Id> accountIds = helper.returnChangedAccounts();

        if (accountIds != null) {
            List<Account> listOfAccount = [SELECT Id, 
            (SELECT Id, Is_Synced__c, Processed_By_Queue__c FROM Contacts) 
            FROM Account WHERE Id IN :accountIds];
    
            List<Contact> contactsForUpdate = new List<Contact>();

            for(Account account : listOfAccount){
                for(Contact contact : account.Contacts){
                    contact.Is_Synced__c = false;
                    contact.Processed_By_Queue__c = true;
                    contactsForUpdate.add(contact);
                }
            }

            update contactsForUpdate;
    }
}
}