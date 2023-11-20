@RestResource (urlMapping = '/LMSUserTest/*')
global class TestApi {
    
    @HTTPPost
    global static void doPost(){
        RestResponse res;
        try{
            res = RestContext.response;
            RestRequest req = RestContext.request;
            
            string requestBody = req.requestBody.toString();
            system.debug('requestBody***'+requestBody);
        }
        catch(Exception e){
            system.debug('Error: ' + e.getMessage());
        }
    }
}