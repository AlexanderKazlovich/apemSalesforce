@isTest
public with sharing class MultiSelectFlowValesTest {

    @isTest
    static void CheckValuesTest(){
        Product2 product1 = new Product2(Name = 'testProuct1');
        Product2 product2 = new Product2(Name = 'testProduct2');
        insert product1;
        insert product2;
        List<String> listOfIds = new List<String>();
        String testString = product1.Id+'; '+product2.Id;
        listOfIds.add(testString);

        Test.startTest();
            List<MultiSelectFlowVales.Result> resultList = MultiSelectFlowVales.CheckValues(listOfIds); 
        Test.stopTest();
        System.assertEquals(2, resultList.get(0).products.size());

    }

}
