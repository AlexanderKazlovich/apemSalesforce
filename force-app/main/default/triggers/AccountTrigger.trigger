trigger AccountTrigger on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    AccountTriggerHandler handler = new AccountTriggerHandler();

    if(Trigger.isBefore && Trigger.isInsert){
        handler.onBeforeInsert();
    }
    if(Trigger.isAfter && Trigger.isInsert){
        handler.onAfterInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        handler.onBeforeUpdate();
    }
    if (Trigger.isAfter && Trigger.isUpdate ) {
        handler.onAfterUpdate(Trigger.old, Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isDelete && TriggerBlocker.isFirstRunTrigger()) {
        TriggerBlocker.setFlagFalse();
        handler.onBeforeDelete();
    }
    if (Trigger.isAfter && Trigger.isDelete) {
        handler.onAfterDelete();
    }
    if (Trigger.isUndelete) {
        handler.onUndelete();
    }
}