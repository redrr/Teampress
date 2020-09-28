package hu.playmaker;

import com.google.api.services.fitness.model.Application;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PlaymakerApplication {

	public static void main(String[] args) {
		System.setProperty("webdriver.chrome.driver","chromedriver.exe");
		SpringApplication.run(PlaymakerApplication.class, args);
	}

}
