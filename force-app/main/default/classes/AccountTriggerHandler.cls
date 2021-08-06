public with sharing class AccountTriggerHandler {

    AccountTriggerHelper helper = new AccountTriggerHelper();

    public void onBeforeInsert(){
        //not implemented yet
    }
    public void onAfterInsert(){
        helper.assignTasks();
    }
    public void onBeforeUpdate(){
        //not implemented yet
    }
    public void onAfterUpdate(){
        helper.assignTasks();
    }
    public void onBeforeDelete(){
        //not implemented yet
    }
    public void onAfterDelete(){
        //not implemented yet
    }
    public void onUndelete(){
        //not implemented yet
    }

}
