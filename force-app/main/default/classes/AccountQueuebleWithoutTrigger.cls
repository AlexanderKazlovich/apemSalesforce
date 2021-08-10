public with sharing class AccountQueuebleWithoutTrigger implements Queueable {
    public void execute(QueueableContext ctx){
        List<Account> listOfAccount = [select Id, 
        (Select Id, Is_Synced__c, Processed_By_Queue__c from Contacts) 
        from Account where BillingCity != null OR BillingCountry != null OR 
                                                BillingGeocodeAccuracy != null OR
                                                BillingLatitude != null OR
                                                BillingLongitude != null OR
                                                BillingPostalCode != null OR
                                                BillingState != null OR
                                                BillingStreet != null
                                     ];

        List<Contact> contactsForUpdate = new List<Contact>();
        if (listOfAccount != null) {
            for(Account acc : listOfAccount){
                for(Contact con : acc.Contacts){
                    con.Is_Synced__c = false;
                    con.Processed_By_Queue__c = true;
                    contactsForUpdate.add(con);
                }
            }
        }
        update contactsForUpdate;
    }
}
