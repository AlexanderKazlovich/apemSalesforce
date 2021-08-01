public class CreateTask {
    @InvocableMethod
    public static void create(List<Account> accounts){
        if(accounts != null){
            List<Task> newTasks = new List<Task>();
            for(Account acc: accounts){
            	Task newTask = new Task();
            	newTask.WhatId = acc.Id;
                newTask.Subject = 'Negotiations with '+ acc.Name;
                newTasks.add(newTask);
            }
            insert newTasks;
        }
    }
}