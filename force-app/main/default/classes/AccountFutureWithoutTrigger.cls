public with sharing class AccountFutureWithoutTrigger {
    @Future
    public static void updateAccounts(){

            List<Account> listOfAccount = [SELECT Id, 
            (SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contacts) 
            FROM Account WHERE BillingCity != null OR BillingCountry != null OR 
                                                    BillingGeocodeAccuracy != null OR
                                                    BillingLatitude != null OR
                                                    BillingLongitude != null OR
                                                    BillingPostalCode != null OR
                                                    BillingState != null OR
                                                    BillingStreet != null
                                         LIMIT 150];
    
            List<Contact> contactsForUpdate = new List<Contact>();
            if (listOfAccount != null) {
                for(Account account : listOfAccount){
                    for(Contact contact : account.Contacts){
                        contact.Is_Synced__c = false;
                        contact.Processed_By_Future__c = true;
                        contactsForUpdate.add(contact);
                    }
                }
            }
            
            update contactsForUpdate;
    }
}