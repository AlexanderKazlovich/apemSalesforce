trigger AccountTrigger on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

    AccountTriggerHandler handler = new AccountTriggerHandler();


    if(Trigger.isBefore && Trigger.isInsert){
        handler.onBeforeInsert();
    }
    if(Trigger.isAfter && Trigger.isInsert){
        handler.onAfterInsert();
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        handler.onBeforeUpdate();
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        handler.onAfterUpdate();
    }
    if (Trigger.isBefore && Trigger.isDelete) {
        handler.onBeforeDelete();
    }
    if (Trigger.isAfter && Trigger.isDelete) {
        handler.onAfterDelete();
    }
    if (Trigger.isUndelete) {
        handler.onUndelete();
    }
}