public with sharing class AccountTriggerHelper {

    private List<Account> oldList;
    private List<Account> newList;

    public AccountTriggerHelper(List<Account> oldList, List<Account> newList){
        this.oldList = oldList;
        this.newList = newList;
    }

    public Set<Id> returnChangedAccounts(){
        Set<Id> setWithChangedAccounts = new Set<Id>();

        for(Account accOld : oldList){
            for (Account accNew : newList) {
                if (accNew.Id == accOld.Id && ( accNew.BillingCity != accOld.BillingCity || 
                                                accNew.BillingCountry != accOld.BillingCountry ||
                                                accNew.BillingState != accOld.BillingState ||
                                                accNew.BillingPostalCode != accOld.BillingPostalCode ||
                                                accNew.BillingLatitude != accOld.BillingLatitude ||
                                                accNew.BillingLongitude != accOld.BillingLongitude ||
                                                accNew.BillingGeocodeAccuracy != accOld.BillingGeocodeAccuracy ||
                                                accNew.BillingStreet != accOld.BillingStreet)) {
                    setWithChangedAccounts.add(accNew.Id);
                }
            }
        }
        System.debug('Old list size = ' + oldList.size() + 'New list size = ' + newList.size());

        return setWithChangedAccounts;
    }

    public void assignTasks(){
        Set<Id> ids = new Set<Id>();
        for(Account acc : newList){
            ids.add(acc.Id);
        }

        List<Account> listOfAccounts = [select id,(select ownerId, whatId from Tasks) from Account where id in : ids];        
        List<Task> tasksForUpdate = new List<Task>();

        for(Account acc : listOfAccounts){
            if(acc.Tasks.size() > 3){
                for(Task t : acc.Tasks){
                    if(t.whatId == acc.Id){
                        t.OwnerId = '0055g00000Bn4IIAAZ';
                        tasksForUpdate.add(t);
                    }
                }
            }
        }
            update tasksForUpdate;
    }
}