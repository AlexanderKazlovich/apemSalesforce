public with sharing class UpdateContacts<T> implements Database.Batchable<Contact>, Iterable<Contact>, Iterator<Contact>  {
    private integer i;
    private List<Contact> contacts;
    public  UpdateContacts(){
        contacts = [SELECT Account.Id, Account.BillingCity, Account.BillingCountry, Account.BillingGeocodeAccuracy,
         Account.Updated_By_Contact__c, Account.BillingLatitude, Account.BillingLongitude, Account.BillingPostalCode, Account.BillingState,
        MailingCity, MailingGeocodeAccuracy, MailingLatitude, Account.BillingStreet, MailingLongitude, MailingStreet,MailingState, MailingPostalCode, MailingCountry, Is_Synced__c from Contact where Is_Synced__c = FALSE];
        i = 0;
    }

    public Iterator<Contact> iterator(){
        return this;
    }
    
    public Boolean hasNext(){
        if(contacts.size() <= i) 
        return false;
      else
        return true;
    }
    public Contact next(){
        i++;
        return contacts[i-1];
    }
    
    
    public Iterable<Contact> start(Database.BatchableContext bc){
        return new UpdateContacts();
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope){
        Map<Id, Account> accountsForUpadate = new Map<Id,Account>();//use map because duplictes was detected
        for(Contact con: scope){
            con.MailingCity = con.Account.BillingCity;
            con.MailingCountry = con.Account.BillingCountry;
            con.MailingGeocodeAccuracy = con.Account.BillingGeocodeAccuracy;
            con.MailingLatitude = con.Account.BillingLatitude;
            con.MailingLongitude = con.Account.BillingLongitude;
            con.MailingPostalCode = con.Account.BillingPostalCode;
            con.MailingState = con.Account.BillingState;
            con.MailingStreet = con.Account.BillingStreet;
            con.Is_Synced__c = true;
            accountsForUpadate.put(con.Account.Id, con.Account);
        }
        for(Account acc : accountsForUpadate.values()){
            acc.Updated_By_Contact__c = true;
        }

        update scope;
        update accountsForUpadate.values();
    }
    public void finish(Database.BatchableContext bc){

    }
}
