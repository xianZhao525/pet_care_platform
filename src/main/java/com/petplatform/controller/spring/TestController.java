package com.petplatform.controller.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

    @GetMapping("/test")
    @ResponseBody // 直接返回文本，不经过 JSP
    public String test() {
        return "✅ Controller 扫描成功！如果看到此消息，说明问题在 JSP 视图解析器";
    }
}