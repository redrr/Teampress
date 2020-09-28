package hu.playmaker.common;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class SimplePay {

    private static final String HMAC_SHA1_ALGORITHM = "HmacSHA384";

    public String convertToBase64(String input) {
        return Base64.getEncoder().encodeToString(input.getBytes());
    }

    public String getHmacSHA384(String merchantKey, String message) {
        try {
            SecretKeySpec signingKey = new SecretKeySpec(merchantKey.getBytes(), HMAC_SHA1_ALGORITHM);
            Mac mac = Mac.getInstance(HMAC_SHA1_ALGORITHM);
            mac.init(signingKey);
            return bytesToHex(mac.doFinal(message.getBytes()));
        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String bytesToHex(final byte[] hash) {
        final StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            final String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
