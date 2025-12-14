<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 宠物领养平台</title>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> --%>
    <link rel="stylesheet" href="src\main\resources\static\css\style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .auth-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 400px);
            padding: 60px 20px;
        }
        
        .auth-card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 100%;
            max-width: 450px;
            padding: 50px 40px;
        }
        
        .auth-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .auth-logo {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 15px;
            display: block;
        }
        
        .auth-title {
            font-size: 1.8rem;
            color: var(--dark-color);
            margin-bottom: 10px;
        }
        
        .auth-subtitle {
            color: var(--text-light);
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark-color);
        }
        
        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e1e5eb;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(78, 151, 253, 0.1);
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }
        
        .input-with-icon .form-control {
            padding-left: 45px;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
        }
        
        .remember-me input {
            margin-right: 8px;
        }
        
        .forgot-password {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .forgot-password:hover {
            text-decoration: underline;
        }
        
        .auth-btn {
            width: 100%;
            padding: 14px;
            font-size: 1.1rem;
        }
        
        .auth-divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
            color: var(--text-light);
        }
        
        .auth-divider::before,
        .auth-divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background-color: #e1e5eb;
        }
        
        .auth-divider span {
            padding: 0 15px;
        }
        
        .social-login {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .social-btn {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 12px;
            border-radius: var(--border-radius);
            border: 2px solid #e1e5eb;
            background-color: white;
            color: var(--dark-color);
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .social-btn:hover {
            border-color: var(--primary-color);
            background-color: #f8fafd;
        }
        
        .social-btn i {
            margin-right: 8px;
            font-size: 1.2rem;
        }
        
        .social-btn.wechat i {
            color: #09bb07;
        }
        
        .social-btn.qq i {
            color: #12b7f5;
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 30px;
            color: var(--text-light);
        }
        
        .auth-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .auth-link:hover {
            text-decoration: underline;
        }
        
        .error-message {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
    </style>
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

    <script>
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
    </script>
</body>
</html>