global class MultiSelectFlowVales{
    @InvocableMethod
    public static List<Result> CheckValues(List<String> values){
        if(!values.isEmpty()){
            String value = values[0];
            List<String> splitValue= value.split('; ');
            List<Product2> listOfProducts = [SELECT Id, isActive FROM Product2 where Id IN :splitValue];
            Result result = new Result();
            result.products = listOfProducts;
            List<Result> listResult = new List<Result>();
            listResult.add(result);
            return listResult;
        } else {return null;}
        
    }
    
    public class Result{
    @InvocableVariable
    public List<Product2> products;
    }
}