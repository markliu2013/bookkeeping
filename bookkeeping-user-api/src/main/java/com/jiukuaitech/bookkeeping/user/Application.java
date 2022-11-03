package com.jiukuaitech.bookkeeping.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.client.RestTemplate;

import java.time.Duration;

@SpringBootApplication
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

//	public static void main(String[] args) {
//		RestTemplate restTemplate = new RestTemplate();
//		String url = "https://www.jiukuaitech.com/2.json";
//		ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
//		LinkedHashMap map = (LinkedHashMap) response.getBody().get("rates");
//		for (Object key : map.keySet()) {
//			System.out.print(key);
//			System.out.print("---");
//			System.out.println(map.get(key));
//		}
//	}

	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		return builder
				.setConnectTimeout(Duration.ofMillis(3000))
				.setReadTimeout(Duration.ofMillis(3000))
				.build();
	}
	
	@Bean
	public RedisTemplate<String, Integer> redisTemplate(RedisConnectionFactory factory) {
        RedisTemplate<String, Integer> template = new RedisTemplate<>();
        template.setConnectionFactory(factory);
        return template;
    }

}
