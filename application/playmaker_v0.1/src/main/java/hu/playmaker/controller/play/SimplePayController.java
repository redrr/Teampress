package hu.playmaker.controller.play;

import hu.playmaker.common.SimplePay;
import hu.playmaker.controller.BaseController;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/pay")
public class SimplePayController extends BaseController {

    private final String text = "{\"salt\":\"806a7a4830351ef68a05f3e2b077fd93\",\"merchant\":\"PUBLICTESTHUF\",\"orderRef\":\"10\n" +
            "1010515680194414779\",\"currency\":\"HUF\",\"customerEmail\":\"sdk_test@otpmobil.com\",\"language\":\"HU\",\n" +
            "\"sdkVersion\":\"SimplePayV2.1_Payment_PHP_SDK_2.0.7_190701:dd236896400d7463677a82a47f53e36e\",\"me\n" +
            "thods\":[\"CARD\"],\"total\":\"25\",\"timeout\":\"2019-09-11T16:30:41+00:00\",\"url\":\"https:\\/\\/sdk.simple\n" +
            "pay.hu\\/back.php\"}";
    private final String merchantKey = "7AB22eW8a12CLxar03226u6o8hL8Uu6v";

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    @ResponseBody
    public String doPay() {
        JSONObject jsonObject = new JSONObject();
        SimplePay simplePay = new SimplePay();
        try {
            jsonObject.put("Signature", simplePay.convertToBase64(simplePay.getHmacSHA384(merchantKey, text)));
            jsonObject.put("salt", "");
            jsonObject.put("merchant", "");
            jsonObject.put("orderRef", "");
            jsonObject.put("currency", "");
            jsonObject.put("customerEmail", "");
            jsonObject.put("language", "");
            jsonObject.put("sdkVersion", "");
            jsonObject.put("methods", "");
            jsonObject.put("total", "");
            jsonObject.put("timeout", "");
            jsonObject.put("url", "https://sdk.simplepay.hu/back.php"
            );
        } catch (Exception e){
            e.printStackTrace();
            return e.getMessage();
        }
        return jsonObject.toString();
    }
}
