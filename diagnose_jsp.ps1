# 保存为 diagnose_jsp.ps1 并运行

Write-Host "=== JSP配置诊断 ===" -ForegroundColor Cyan

# 1. 检查目录结构
Write-Host "`n1. 检查目录结构:" -ForegroundColor Yellow
if (Test-Path "src/main/webapp/WEB-INF/views/index.jsp") {
    Write-Host "✅ index.jsp 位置正确" -ForegroundColor Green
} else {
    Write-Host "❌ index.jsp 位置错误或不存在" -ForegroundColor Red
    Write-Host "   应该在: src/main/webapp/WEB-INF/views/index.jsp" -ForegroundColor Red
}

# 2. 检查pom.xml中的JSP依赖
Write-Host "`n2. 检查pom.xml依赖:" -ForegroundColor Yellow
if (Test-Path "pom.xml") {
    $hasJasper = Select-String -Path "pom.xml" -Pattern "tomcat-embed-jasper" -Quiet
    $hasJstl = Select-String -Path "pom.xml" -Pattern "jstl" -Quiet
    
    if ($hasJasper) {
        Write-Host "✅ tomcat-embed-jasper 依赖存在" -ForegroundColor Green
    } else {
        Write-Host "❌ tomcat-embed-jasper 依赖不存在" -ForegroundColor Red
    }
    
    if ($hasJstl) {
        Write-Host "✅ jstl 依赖存在" -ForegroundColor Green
    } else {
        Write-Host "❌ jstl 依赖不存在" -ForegroundColor Red
    }
}

# 3. 检查application.properties配置
Write-Host "`n3. 检查application.properties:" -ForegroundColor Yellow
if (Test-Path "src/main/resources/application.properties") {
    $content = Get-Content "src/main/resources/application.properties"
    $hasPrefix = $content | Select-String "spring.mvc.view.prefix" -Quiet
    $hasSuffix = $content | Select-String "spring.mvc.view.suffix" -Quiet
    
    if ($hasPrefix) {
        Write-Host "✅ spring.mvc.view.prefix 已配置" -ForegroundColor Green
        $content | Select-String "spring.mvc.view.prefix"
    } else {
        Write-Host "❌ spring.mvc.view.prefix 未配置" -ForegroundColor Red
    }
    
    if ($hasSuffix) {
        Write-Host "✅ spring.mvc.view.suffix 已配置" -ForegroundColor Green
        $content | Select-String "spring.mvc.view.suffix"
    } else {
        Write-Host "❌ spring.mvc.view.suffix 未配置" -ForegroundColor Red
    }
}

# 4. 创建最简单的测试JSP
Write-Host "`n4. 创建测试JSP..." -ForegroundColor Yellow
$testJsp = @"
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP测试页面</title>
</head>
<body>
    <h1>✅ JSP测试成功！</h1>
    <p>如果看到这个页面，说明JSP配置正确。</p>
    <p>当前时间: <%= new java.util.Date() %></p>
    <p><a href="/">返回首页</a></p>
</body>
</html>
"@

$testJsp | Out-File -FilePath "src/main/webapp/WEB-INF/views/test.jsp" -Encoding UTF8
Write-Host "✅ 测试JSP已创建: src/main/webapp/WEB-INF/views/test.jsp" -ForegroundColor Green

# 5. 创建测试控制器
Write-Host "`n5. 创建测试控制器..." -ForegroundColor Yellow
$testController = @"
package com.petplatform.controller.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestJspController {
    
    @GetMapping("/test-jsp")
    public String testJsp() {
        return "test";
    }
    
    @GetMapping("/simple")
    public String simple() {
        return "test";
    }
}
"@

$controllerDir = "src/main/java/com/petplatform/controller/test"
New-Item -ItemType Directory -Path $controllerDir -Force | Out-Null
$testController | Out-File -FilePath "$controllerDir/TestJspController.java" -Encoding UTF8
Write-Host "✅ 测试控制器已创建" -ForegroundColor Green

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan
Write-Host "`n现在请运行以下步骤：" -ForegroundColor Yellow
Write-Host "1. 重新编译: mvn clean compile" -ForegroundColor White
Write-Host "2. 启动应用: mvn spring-boot:run" -ForegroundColor White
Write-Host "3. 访问测试页: http://localhost:8080/test-jsp" -ForegroundColor White
Write-Host "4. 访问简单页: http://localhost:8080/simple" -ForegroundColor White