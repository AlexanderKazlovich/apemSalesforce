public with sharing class UpdateContactsScheduler implements Schedulable {

    public void execute(SchedulableContext sct){
        Database.executeBatch(new UpdateContacts());
    }
}

