@isTest
public with sharing class WebServiceRestAPITest {


    @isTest
    static void getAccountByIdTest(){
        Id accountId = TestDataFactory.ACCOUNT.createTestAccount('test', null, true).Id;
        RestRequest request = new RestRequest();
        request.requestURI='https://epam-e6-dev-ed.my.salesforce.com/services/apexrest/Account/'+accountId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account account = WebServiceRestAPI.getAccountById();
        System.assert(account != null);
        System.assertEquals('test', account.Name);
    }

    @isTest
    static void createAccountTest(){
        Id accountId = WebServiceRestAPI.createAccount('test', '100');
        System.assert(accountId != null);
        Account account = [SELECT Id, Name FROm Account WHERE id =: accountId];
        System.assert(account != null);
        System.assertEquals(account.Name, 'test');

    }

    @isTest
    static void deleteAccountByIdTest(){
        Id accountId = TestDataFactory.ACCOUNT.createTestAccount('test', 'Minsk', true).Id;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://epam-e6-dev-ed.my.salesforce.com/services/apexrest/Account/'+ accountId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        WebServiceRestAPI.deleteAccountById();
        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :accountId];
        System.assert(accounts.size() == 0);
    }

    @isTest
    static void upsertAccountTest(){
        //insert record
        Id accountId = WebServiceRestAPI.upsertAccount(null,'test', 100);
        System.assert(accountId != null);
        Account account = [SELECT Id, NumberOfEmployees FROM Account WHERE Id=:accountId];
        System.assert(account != null);
        System.assertEquals(100, account.NumberOfEmployees);
        //update record
        Id accountIdAfterUpsert = WebServiceRestAPI.upsertAccount(accountId, 'test1', 200);
        System.assertEquals(accountId, accountIdAfterUpsert);
        System.assertEquals(200, [SELECT NumberOfEmployees FROM Account WHERE Id = :accountIdAfterUpsert].NumberOfEmployees);
        System.assertEquals('test1', [SELECT Name FROM Account WHERE Id = :accountIdAfterUpsert].Name);

    }

    @isTest
    static void updateAccountTest(){
        Id accountId = TestDataFactory.ACCOUNT.createTestAccount('test', 'Minsk', true).Id;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://epam-e6-dev-ed.my.salesforce.com/services/apexrest/Account/'+accountId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"NumberOfEmployees": "150"}');
        RestContext.request = request;
        //Verify
        Id thisAccountId = WebServiceRestAPI.updateAccount();
        System.assert(thisAccountId != null);
        Account account = [SELECT Id, NumberOfEmployees FROM Account WHERE Id = :thisAccountId];
        System.assert(account != null);
        System.assertEquals(150, account.NumberOfEmployees);
    }
}
