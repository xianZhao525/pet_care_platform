package com.petplatform.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

        @Bean
        public PasswordEncoder passwordEncoder() {
                return new BCryptPasswordEncoder();
        }

        // ✅ 核心修复：移除formLogin配置，让自定义Controller处理所有请求
        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
                http
                                .csrf().disable() // 开发环境禁用
                                .authorizeRequests(auth -> auth
                                                // 静态资源
                                                .antMatchers("/css/**", "/js/**", "/images/**", "/static/**",
                                                                "/favicon.ico")
                                                .permitAll()
                                                // 公开页面（注意：必须放行所有/user/**和/admin/**路径）
                                                .antMatchers("/", "/index", "/pet/**", "/foster/**", "/donation/**",
                                                                "/user/login", "/user/register", "/user/logout",
                                                                "/user/**",
                                                                "/admin/**")
                                                .permitAll()
                                                // 其他需要认证
                                                .anyRequest().authenticated())
                                // ✅ 移除formLogin配置
                                .logout(logout -> logout
                                                .logoutUrl("/user/logout")
                                                .logoutSuccessUrl("/user/login?logout=true")
                                                .invalidateHttpSession(true)
                                                .deleteCookies("JSESSIONID")
                                                .permitAll());

                return http.build();
        }
}