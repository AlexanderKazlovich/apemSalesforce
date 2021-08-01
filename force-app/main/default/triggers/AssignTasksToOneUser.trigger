trigger AssignTasksToOneUser on Account (after update) {
    Set<Id> accountIds = new Set<Id>();
    for(Account acc : Trigger.old){
        accountIds.add(acc.Id);
    }
    
    List<Account> listOfAccounts = [select id,(select ownerId, whatId from Tasks) from Account where id in : accountIds];
    List<Task> tasksForUpdate = [select id, ownerid, whatId from Task where whatId in :accountIds];
    
    for(Account acc : listOfAccounts){
        if(acc.Tasks.size() > 3){
            for(Task t : tasksForUpdate){
                if(t.whatId == acc.Id){
                    t.OwnerId = '0055g00000Bn4IIAAZ';
                }
            }
        }
    }
    
    update tasksForUpdate;
}