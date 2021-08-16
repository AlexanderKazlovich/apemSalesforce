public with sharing class UpdateTasksScheduler implements Schedulable {
    public void execute(SchedulableContext sct){
        Database.executeBatch(new UpdateTasks());
    }
}