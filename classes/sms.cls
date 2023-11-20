public class sms {
    public static void sendOTPSMS(String otp,string toPhone) {
        String accountSid = 'AC4fd2e762e18f3c21ebbbb3715517f20e';
        String authToken = 'ab45c646f1a2a21f799e49a9f69ac9ad'; // Replace this with your Twilio Auth Token
        String toPhoneNumber=toPhone;
        string otpCode=generateOtp();
        String fromPhoneNumber = '+19894742752'; // Your Twilio phone number
        
        String endpoint = 'https://api.twilio.com/2010-04-01/Accounts/' + accountSid + '/Messages.json';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(accountSid + ':' + authToken)));
        
        String body = 'To=' + EncodingUtil.urlEncode(toPhoneNumber, 'UTF-8')
            + '&From=' + EncodingUtil.urlEncode(fromPhoneNumber, 'UTF-8')
            + '&Body=Your OTP is: ' + otp;
        system.debug(body);
        req.setBody(body);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 201) {
            System.debug('OTP SMS sent successfully.');
        } else {
            System.debug('Error sending OTP SMS. Status Code: ' + res.getStatusCode());
            System.debug('Response Body: ' + res.getBody());
        }
    }
    public static String generateOtp(){
        String responseList;
        String randomIntegerString = string.valueof(Math.abs(Crypto.getRandomInteger()));
        String otp = randomIntegerString.substring(0,6);
        responseList=otp;
        return responseList;
    }
}