public with sharing class TriggerBlocker {
    private static Boolean flag = true;

    public static Boolean isFirstRunTrigger(){
        return flag;
    }

    public static void setFlagFalse(){
        flag = false;
    }
}