public with sharing class AccountBatchWithoutTrigger implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Account.Id, Account.BillingCity, Account.BillingCountry, Account.BillingGeocodeAccuracy,' +
        'Account.Updated_By_Contact__c, Account.BillingLatitude, Account.BillingLongitude, Account.BillingPostalCode, Account.BillingState,' +
       'MailingCity, MailingGeocodeAccuracy, MailingLatitude, Account.BillingStreet, MailingLongitude, MailingStreet,MailingState, MailingPostalCode, MailingCountry, Is_Synced__c from Contact where Is_Synced__c = FALSE');
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
