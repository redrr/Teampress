package hu.playmaker.handler.config;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class SeleniumConfig {

    private WebDriver webDriver;

    public SeleniumConfig() {
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.addArguments("window-size=1920,1080");
        chromeOptions.setHeadless(true);
        webDriver = new ChromeDriver(chromeOptions);
    }

    public WebDriver getWebDriver(){
        return webDriver;
    }
}
