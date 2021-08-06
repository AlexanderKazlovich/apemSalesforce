trigger AccountTrigger on Account (after update) {
    System.debug(TriggerBlocker.isFirstRunTrigger());
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
    if (Trigger.isAfter && Trigger.isUpdate && TriggerBlocker.isFirstRunTrigger()) {
        TriggerBlocker.setFlagFalse();
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