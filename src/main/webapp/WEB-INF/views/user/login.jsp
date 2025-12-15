<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 宠物领养平台</title>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> --%>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar">
        <div class="container navbar-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <i class="fas fa-paw"></i> 宠物领养平台
            </a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/pets">领养宠物</a></li>
                <li><a href="${pageContext.request.contextPath}/foster">临时寄养</a></li>
                <li><a href="${pageContext.request.contextPath}/donate">爱心捐赠</a></li>
                <li><a href="${pageContext.request.contextPath}/about">关于我们</a></li>
            </ul>
            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline">注册</a>
            </div>
        </div>
    </nav>

    <!-- 登录表单 -->
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <a href="${pageContext.request.contextPath}/index.jsp" class="auth-logo">
                    <i class="fas fa-paw"></i>
                </a>
                <h1 class="auth-title">欢迎回来</h1>
                <p class="auth-subtitle">登录您的账号，继续帮助小生命</p>
            </div>
            
            <!-- 错误消息 -->
            <div class="error-message" id="errorMessage">
                <i class="fas fa-exclamation-circle"></i> 用户名或密码错误，请重试
            </div>
            
            <!-- 成功消息 -->
            <div class="success-message" id="successMessage">
                <i class="fas fa-check-circle"></i> 注册成功，请登录您的账号
            </div>
            
            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="POST">
                <div class="form-group">
                    <label for="username" class="form-label">用户名或邮箱</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名或邮箱" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">密码</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码" required>
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
                <p>还没有账号？ <a href="${pageContext.request.contextPath}/register.jsp" class="auth-link">立即注册</a></p>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-about">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="footer-logo">
                        <i class="fas fa-paw"></i> 宠物领养平台
                    </a>
                    <p class="footer-description">
                        我们致力于为流浪宠物寻找温暖的家，通过领养代替购买，减少流浪动物的数量。
                    </p>
                </div>
                
                <div class="footer-links">
                    <h4>快速链接</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
                        <li><a href="${pageContext.request.contextPath}/pets">领养宠物</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">关于我们</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">联系我们</a></li>
                    </ul>
                </div>
                
                <div class="footer-contact">
                    <h4>联系我们</h4>
                    <p><i class="fas fa-phone"></i> 400-123-4567</p>
                    <p><i class="fas fa-envelope"></i> contact@petadoption.com</p>
                </div>
            </div>
            
            <div class="copyright">
                <p>&copy; 2025 宠物领养平台. 版权所有.</p>
            </div>
        </div>
    </footer>

    <%-- <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const errorMessage = document.getElementById('errorMessage');
            const successMessage = document.getElementById('successMessage');
            
            // 检查URL参数，显示相应的消息
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('error') === 'true') {
                errorMessage.style.display = 'block';
            }
            
            if (urlParams.get('registered') === 'true') {
                successMessage.style.display = 'block';
            }
            
            // 表单提交验证
            loginForm.addEventListener('submit', function(e) {
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                if (!username || !password) {
                    e.preventDefault();
                    errorMessage.textContent = '请输入用户名和密码';
                    errorMessage.style.display = 'block';
                    return;
                }
                
                // 简单的客户端验证
                if (password.length < 6) {
                    e.preventDefault();
                    errorMessage.textContent = '密码长度至少为6位';
                    errorMessage.style.display = 'block';
                    return;
                }
                
                // 显示加载状态
                const submitBtn = loginForm.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 登录中...';
                submitBtn.disabled = true;
                
                // 在实际项目中，这里会发送表单数据到服务器
                // 这里只是模拟
                setTimeout(function() {
                    submitBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> 登录';
                    submitBtn.disabled = false;
                }, 1500);
            });
            
            // 社交登录按钮点击事件
            document.querySelectorAll('.social-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const socialType = this.classList.contains('wechat') ? '微信' : 'QQ';
                    alert('即将通过' + socialType + '登录，此功能正在开发中');
                });
            });
        });
    </script> --%>
</body>
</html>