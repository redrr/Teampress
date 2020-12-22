package hu.playmaker.controller.basic;

import hu.playmaker.common.factory.mlsz.MLSZ;
import hu.playmaker.common.factory.mlsz.MLSZParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

@Controller
public class TestController {

    @RequestMapping("/test")
    @ResponseBody
    public void test() throws IOException, URISyntaxException {
        //Document page = Jsoup.connect("http://ada1bank.mlsz.hu/player?itemId=373780").get();

        new MLSZParser("http://ada1bank.mlsz.hu/player?itemId=373780", MLSZ.PLAYER_PROFILE);
    }
}
