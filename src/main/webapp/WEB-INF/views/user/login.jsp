<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%-- 引入公共导航栏 --%>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <%-- 在 auth-header 下方添加 --%>

                <%-- 显示Spring Security重定向的错误（当参数error=true时） --%>
                <c:if test="${not empty param.error}">
                    <div class="error-message" style="display: block; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-circle"></i> 用户名或密码错误
                    </div>
                </c:if>

                <%-- 显示自定义Controller传递的Flash错误 --%>
                <c:if test="${not empty loginError}">
                    <div class="error-message" style="display: block; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-circle"></i> 
                        ${empty errorMessage ? '登录失败' : errorMessage}
                    </div>
                </c:if>

                <%-- 显示注册成功Flash消息 --%>
                <c:if test="${not empty registered}">
                    <div class="success-message" style="display: block; margin-bottom: 20px;">
                        <i class="fas fa-check-circle"></i> 注册成功，请登录您的账号
                    </div>
                </c:if>

                <%-- 显示登出成功消息 --%>
                <c:if test="${not empty param.logout}">
                    <div class="success-message" style="display: block; margin-bottom: 20px;">
                        <i class="fas fa-check-circle"></i> 您已成功退出登录
                    </div>
                </c:if>
                <a href="${pageContext.request.contextPath}/" class="auth-logo">
                    <i class="fas fa-paw"></i>
                </a>
                <h1 class="auth-title">欢迎回来</h1>
                <p class="auth-subtitle">登录您的账号，继续帮助小生命</p>
            </div>
            
            <%-- 显示登录错误消息（Flash属性） --%>
            <c:if test="${not empty loginError}">
                <div class="error-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> 
                    ${empty errorMessage ? '用户名或密码错误' : errorMessage}
                </div>
            </c:if>
            
            <%-- 显示注册成功消息 --%>
            <c:if test="${not empty registered}">
                <div class="success-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-check-circle"></i> 注册成功，请登录您的账号
                </div>
            </c:if>
            
            <%-- 显示登出成功消息 --%>
            <c:if test="${not empty param.logout}">
                <div class="success-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-check-circle"></i> 您已成功退出登录
                </div>
            </c:if>
            
            <%-- 登录表单 --%>
            <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="POST">
                <div class="form-group">
                    <label for="username" class="form-label">用户名</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="username" name="username" class="form-control" 
                               placeholder="请输入用户名" required autofocus>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">密码</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="请输入密码" required>
                    </div>
                </div>
                
                <div class="remember-forgot">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">记住我</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password.jsp" class="forgot-password">忘记密码？</a>
                </div>
                
                <button type="submit" class="btn btn-primary auth-btn">
                    <i class="fas fa-sign-in-alt"></i> 登录
                </button>
            </form>
            
            <div class="auth-divider">
                <span>或使用以下方式登录</span>
            </div>
            
            <div class="social-login">
                <button type="button" class="social-btn wechat">
                    <i class="fab fa-weixin"></i> 微信
                </button>
                <button type="button" class="social-btn qq">
                    <i class="fab fa-qq"></i> QQ
                </button>
            </div>
            
            <div class="auth-footer">
                <p>还没有账号？ <a href="${pageContext.request.contextPath}/user/register" class="auth-link">立即注册</a></p>
            </div>
        </div>
    </div>

    <%-- 引入公共页脚 --%>
    <%-- <%@ include file="../common/footer.jsp" %> --%>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            
            // 表单提交验证
            loginForm.addEventListener('submit', function(e) {
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                if (!username || !password) {
                    e.preventDefault();
                    alert('请输入用户名和密码');
                    return;
                }
                
                if (password.length < 6) {
                    e.preventDefault();
                    alert('密码长度至少为6位');
                    return;
                }
                
                // 显示加载状态
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 登录中...';
                submitBtn.disabled = true;
                submitBtn.style.opacity = '0.7';
            });
            
            // 社交登录按钮点击事件
            document.querySelectorAll('.social-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const socialType = this.classList.contains('wechat') ? '微信' : 'QQ';
                    alert('即将通过' + socialType + '登录，此功能正在开发中');
                });
            });
            
            // 3秒后隐藏成功/错误消息
            const messages = document.querySelectorAll('.error-message, .success-message');
            messages.forEach(msg => {
                if (msg.style.display === 'block') {
                    setTimeout(() => {
                        msg.style.display = 'none';
                    }, 5000);
                }
            });
        });
    </script>
</body>
</html>