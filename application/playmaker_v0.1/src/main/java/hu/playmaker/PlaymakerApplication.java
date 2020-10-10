package hu.playmaker;

import com.google.api.services.fitness.model.Application;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class PlaymakerApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		System.setProperty("webdriver.chrome.driver","chromedriver_85.exe");
		SpringApplication.run(PlaymakerApplication.class, args);
	}

}
