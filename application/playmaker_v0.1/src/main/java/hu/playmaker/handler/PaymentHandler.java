package hu.playmaker.handler;

import com.stripe.Stripe;
import com.stripe.exception.*;
import com.stripe.model.Charge;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.Map;

@Service
public class PaymentHandler {

    @Value("${STRIPE_SECRET_KEY}")
    String secretKey;

    @PostConstruct
    public void init() {
        Stripe.apiKey = secretKey;
    }

    public Charge charge(ChargeRequest chargeRequest) throws CardException, APIException, AuthenticationException, InvalidRequestException, APIConnectionException {
        Map<String, Object> chargeParams = new HashMap<>();
        chargeParams.put("amount", chargeRequest.getAmount());
        chargeParams.put("currency", chargeRequest.getCurrency());
        chargeParams.put("description", chargeRequest.getDescription());
        chargeParams.put("source", chargeRequest.getStripeToken());
        return Charge.create(chargeParams);
    }
}
