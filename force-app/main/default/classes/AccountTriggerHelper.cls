public with sharing class AccountTriggerHelper {

    private List<Account> oldList;
    private List<Account> newList;

    public AccountTriggerHelper(List<Account> oldList, List<Account> newList){
        this.oldList = oldList;
        this.newList = newList;
    }

    public List<Id> getIdsFromTriggerNew(){
        List<Id> listId = new List<Id>();
        for(Account account : newList){
            listId.add(account.Id);
        }
        return listId;
    }

    public Set<Id> returnChangedAccounts(){
        Set<Id> changedAccounts = new Set<Id>();
        Map<Id, Account> oldRecords = new Map<Id, Account>(oldList); 
        for(Account newAccount : newList){
            Account oldAccount = oldRecords.get(newAccount.Id);
                if (newAccount.BillingCity != oldAccount.BillingCity || 
                    newAccount.BillingCountry != oldAccount.BillingCountry ||
                    newAccount.BillingState != oldAccount.BillingState ||
                    newAccount.BillingPostalCode != oldAccount.BillingPostalCode ||
                    newAccount.BillingLatitude != oldAccount.BillingLatitude ||
                    newAccount.BillingLongitude != oldAccount.BillingLongitude ||
                    newAccount.BillingGeocodeAccuracy != oldAccount.BillingGeocodeAccuracy ||
                    newAccount.BillingStreet != oldAccount.BillingStreet) 
                {
                    changedAccounts.add(newAccount.Id);
                }
            
        }

        return changedAccounts;
    }

    public void assignTasks(){
        Set<Id> ids = new Set<Id>();
        for(Account account : newList){
            ids.add(account.Id);
        }

        List<Account> listOfAccounts = [SELECT id,(SELECT OwnerId, WhatId FROM Tasks) FROM Account WHERE id IN : ids];        
        List<Task> tasksForUpdate = new List<Task>();

        for(Account account : listOfAccounts){
            if(account.Tasks.size() > 3){
                for(Task task : account.Tasks){
                    if(task.whatId == account.Id){
                        task.OwnerId = '0055g00000Bn4IIAAZ';
                        tasksForUpdate.add(task);
                    }
                }
            }
        }

            update tasksForUpdate;
    }
}