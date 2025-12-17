package com.petplatform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
// 显式指定扫描 Controller 所在包（最关键）
@ComponentScan(basePackages = { "com.petplatform", "com.petplatform.config", "com.petplatform.service",
        "com.petplatform.dao", "com.petplatform.controller" })
@ServletComponentScan("com.petplatform")

// @SpringBootApplication
public class PetCareApplication extends SpringBootServletInitializer {
    /**
     * 配置1：告诉嵌入式 Tomcat src/main/webapp 是 Web 资源目录
     * 解决：Could not resolve view with name 'index' 问题
     */
    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> tomcatCustomizer() {
        return factory -> {
            // 关键：设置文档根目录为 src/main/webapp
            factory.setDocumentRoot(new java.io.File("src/main/webapp"));
        };
    }

    /**
     * 配置2：显式配置 JSP 视图解析器
     * 确保 Spring MVC 去 /WEB-INF/views/ 查找 JSP
     */
    @Bean
    public ViewResolver jspViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(2); // 设置优先级
        return resolver;
    }

    /**
     * 配置3：静态资源处理
     * 允许从 src/main/webapp 加载 CSS/JS/图片
     */
    @Configuration
    public static class WebConfig implements WebMvcConfigurer {
        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {
            // 允许从 src/main/webapp 加载所有资源
            registry.addResourceHandler("/**")
                    .addResourceLocations("file:src/main/webapp/");
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(PetCareApplication.class, args);
        System.out.println("========================================");
        System.out.println("✅ 应用启动完成！");
        System.out.println("✅ 访问地址: http://localhost:8080");
        System.out.println("========================================");
    }
}