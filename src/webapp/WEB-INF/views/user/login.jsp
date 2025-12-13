
$loginJsp = @'
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录 - 宠物领养平台</title>
</head>
<body>
    <h2>登录页面</h2>
    <p>这是一个测试登录页面</p>
    <a href="/">返回首页</a>
</body>
</html>
'@

$loginJsp | Out-File "src/main/webapp/WEB-INF/views/login.jsp" -Encoding UTF8

# 创建 register.jsp
$registerJsp = @'
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>注册 - 宠物领养平台</title>
</head>
<body>
    <h2>注册页面</h2>
    <p>这是一个测试注册页面</p>
    <a href="/">返回首页</a>
</body>
</html>
'@

$registerJsp | Out-File "src/main/webapp/WEB-INF/views/register.jsp" -Encoding UTF8

Write-Host "✅ 已创建 login.jsp 和 register.jsp"