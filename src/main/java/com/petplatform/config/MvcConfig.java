// package com.petplatform.config;

// import org.springframework.context.annotation.Configuration;
// import org.springframework.web.servlet.config.annotation.EnableWebMvc;
// import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
// import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// @Configuration
// @EnableWebMvc
// public class MvcConfig implements WebMvcConfigurer {

//     @Override
//     public void addResourceHandlers(ResourceHandlerRegistry registry) {
//         registry.addResourceHandler("/css/**")
//                 .addResourceLocations("classpath:/static/css/");
//         registry.addResourceHandler("/js/**")
//                 .addResourceLocations("classpath:/static/js/");
//         registry.addResourceHandler("/images/**")
//                 .addResourceLocations("classpath:/static/images/");
//     }
// }

package com.petplatform.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {
                // 方案1：支持带/static前缀的路径
                // registry.addResourceHandler("/static/**")
                // .addResourceLocations("classpath:/static/");

                // 方案2：支持直接从根路径访问（兼容你现在的JSP）
                registry.addResourceHandler("/css/**")
                                .addResourceLocations("classpath:/static/css/");
                registry.addResourceHandler("/js/**")
                                .addResourceLocations("classpath:/static/js/");
                registry.addResourceHandler("/images/**")
                                .addResourceLocations("classpath:/static/images/");
        }
}