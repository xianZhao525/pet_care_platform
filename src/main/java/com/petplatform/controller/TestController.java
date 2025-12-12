package com.petplatform.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    // @GetMapping("/")
    // public String home() {
    // return "<h1>🐕 宠物护理平台</h1>" +
    // "<p>应用启动成功！</p>" +
    // "<p><a href='/health'>健康检查</a></p>" +
    // "<p><a href='/test'>测试接口</a></p>";
    // }

    @GetMapping("/health")
    public String health() {
        return "{\"status\":\"UP\",\"timestamp\":\"" + new java.util.Date() + "\"}";
    }

    @GetMapping("/test")
    public String test() {
        return "✅ 测试接口正常响应";
    }
}