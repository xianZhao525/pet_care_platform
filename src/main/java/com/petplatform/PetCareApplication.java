package com.petplatform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

@SpringBootApplication
public class PetCareApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(PetCareApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(PetCareApplication.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void printConfig() {
        // 获取并打印数据源配置
        String url = System.getProperty("spring.datasource.url");
        String user = System.getProperty("spring.datasource.username");
        String pwd = System.getProperty("spring.datasource.password");

        System.out.println("=== 当前数据源配置 ===");
        System.out.println("URL: " + (url != null ? url : "未设置"));
        System.out.println("Username: " + (user != null ? user : "未设置"));
        System.out.println("Password: " + (pwd != null ? "***" + pwd.substring(Math.max(0, pwd.length() - 3)) : "未设置"));
    }
}