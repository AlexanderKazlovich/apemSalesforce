public with sharing class UpdateContacts implements Database.Batchable<Contact>{

    
    public Iterable<Contact> start(Database.BatchableContext bc){
        return [SELECT Account.Id, Account.BillingCity, Account.BillingCountry, Account.BillingGeocodeAccuracy,
        Account.Updated_By_Contact__c, Account.BillingLatitude, Account.BillingLongitude, Account.BillingPostalCode, Account.BillingState,
        MailingCity, MailingGeocodeAccuracy, MailingLatitude, Account.BillingStreet, MailingLongitude, MailingStreet,MailingState, MailingPostalCode, MailingCountry, Is_Synced__c FROM Contact WHERE Is_Synced__c = false];
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope){
        Map<Id, Account> accountsForUpadate = new Map<Id,Account>();//use map because duplictes was detected
        for(Contact contact: scope){
            contact.MailingCity = contact.Account.BillingCity;
            contact.MailingCountry = contact.Account.BillingCountry;
            contact.MailingGeocodeAccuracy = contact.Account.BillingGeocodeAccuracy;
            contact.MailingLatitude = contact.Account.BillingLatitude;
            contact.MailingLongitude = contact.Account.BillingLongitude;
            contact.MailingPostalCode = contact.Account.BillingPostalCode;
            contact.MailingState = contact.Account.BillingState;
            contact.MailingStreet = contact.Account.BillingStreet;
            contact.Is_Synced__c = true;
            accountsForUpadate.put(contact.Account.Id, contact.Account);
        }
        for(Account account : accountsForUpadate.values()){
            account.Updated_By_Contact__c = true;
        }

        update scope;
        update accountsForUpadate.values();
    }
    public void finish(Database.BatchableContext bc){
        //not implemented yet
    }
}
