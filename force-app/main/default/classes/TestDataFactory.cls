@isTest
public with sharing class TestDataFactory {

    public static TestAccountFactory ACCOUNT = new TestAccountFactory();

    public class TestAccountFactory{
        public Account createTestAccount(String name, String billingCity, Boolean needInsert){
            Account account = new Account();
            account.Name = name;
            account.BillingCity = billingCity;
            if (needInsert) {
                insert account;
            }

            return account;
        }

        public List<Account> createListOfAccounts(Integer count, String name, Boolean needInsert){
            List<Account> accounts = new List<Account>();
            for (Integer i = 0; i < count; i++) {
                Account account = new Account();
                account.Name = name + i;
                accounts.add(account);
            }

            if (needInsert) {
                insert accounts;
            }

            return accounts;
        }
    }
}
