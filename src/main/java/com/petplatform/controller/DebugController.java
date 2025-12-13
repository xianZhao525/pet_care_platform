package com.petplatform.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
public class DebugController {

    @Autowired
    private ServletContext servletContext;

    @GetMapping("/debug/jsp")
    public String debugJsp() {
        StringBuilder sb = new StringBuilder();
        sb.append("<h1>JSP调试信息</h1>");

        // 检查Servlet信息
        sb.append("<h2>Servlet信息</h2>");
        sb.append("<pre>");
        sb.append("Server Info: ").append(servletContext.getServerInfo()).append("\n");
        sb.append("Servlet Version: ").append(servletContext.getMajorVersion()).append(".")
                .append(servletContext.getMinorVersion()).append("\n");

        // 检查JSP支持
        try {
            Class.forName("org.apache.jasper.servlet.JspServlet");
            sb.append("JspServlet: 已加载\n");
        } catch (ClassNotFoundException e) {
            sb.append("JspServlet: 未找到\n");
        }

        // 检查资源路径
        sb.append("\n<h2>资源路径</h2>");
        java.net.URL url = getClass().getClassLoader().getResource("WEB-INF/views/");
        sb.append("WEB-INF/views URL: ").append(url).append("\n");

        sb.append("</pre>");
        return sb.toString();
    }

    @GetMapping("/debug/info")
    public String info() {
        return "{\"status\":\"running\",\"time\":\"" + new java.util.Date() + "\"}";
    }

    @GetMapping("/health")
    public String health() {
        return "{\"status\":\"UP\",\"timestamp\":\"" + new java.util.Date() + "\"}";
    }
}