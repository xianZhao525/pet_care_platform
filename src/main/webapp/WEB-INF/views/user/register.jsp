<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            max-width: 500px;
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
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .terms-agreement {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
        }
        
        .terms-agreement input {
            margin-top: 5px;
            margin-right: 10px;
        }
        
        .terms-agreement label {
            font-size: 0.95rem;
            color: var(--text-light);
            line-height: 1.5;
        }
        
        .terms-link {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .terms-link:hover {
            text-decoration: underline;
        }
        
        .auth-btn {
            width: 100%;
            padding: 14px;
            font-size: 1.1rem;
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
        
        .password-strength {
            margin-top: 8px;
            height: 6px;
            background-color: #e1e5eb;
            border-radius: 3px;
            overflow: hidden;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0%;
            background-color: #ff5252;
            transition: width 0.3s ease;
        }
        
        .password-strength-text {
            font-size: 0.85rem;
            margin-top: 5px;
            color: var(--text-light);
        }
        
        .password-requirements {
            font-size: 0.85rem;
            color: var(--text-light);
            margin-top: 8px;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 4px;
        }
        
        .requirement i {
            margin-right: 5px;
            font-size: 0.8rem;
        }
        
        .requirement.valid {
            color: var(--success-color);
        }
        
        .requirement.invalid {
            color: var(--text-light);
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
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">登录</a>
            </div>
        </div>
    </nav>

    <!-- 注册表单 -->
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <a href="${pageContext.request.contextPath}/index.jsp" class="auth-logo">
                    <i class="fas fa-paw"></i>
                </a>
                <h1 class="auth-title">创建新账号</h1>
                <p class="auth-subtitle">加入我们，为流浪宠物提供一个温暖的家</p>
            </div>
            
            <!-- 错误消息 -->
            <div class="error-message" id="errorMessage">
                <i class="fas fa-exclamation-circle"></i> 注册失败，请检查输入信息
            </div>
            
            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName" class="form-label">姓氏</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" id="firstName" name="firstName" class="form-control" placeholder="请输入姓氏" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="lastName" class="form-label">名字</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" id="lastName" name="lastName" class="form-control" placeholder="请输入名字" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">电子邮箱</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="请输入电子邮箱" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="phone" class="form-label">手机号码</label>
                    <div class="input-with-icon">
                        <i class="fas fa-phone input-icon"></i>
                        <input type="tel" id="phone" name="phone" class="form-control" placeholder="请输入手机号码" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="username" class="form-label">用户名</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user-circle input-icon"></i>
                        <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">密码</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码" required>
                    </div>
                    
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <div class="password-strength-text" id="passwordStrengthText">密码强度：弱</div>
                    
                    <div class="password-requirements">
                        <div class="requirement invalid" id="lengthReq">
                            <i class="fas fa-times-circle"></i> 至少8个字符
                        </div>
                        <div class="requirement invalid" id="uppercaseReq">
                            <i class="fas fa-times-circle"></i> 至少一个大写字母
                        </div>
                        <div class="requirement invalid" id="lowercaseReq">
                            <i class="fas fa-times-circle"></i> 至少一个小写字母
                        </div>
                        <div class="requirement invalid" id="numberReq">
                            <i class="fas fa-times-circle"></i> 至少一个数字
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword" class="form-label">确认密码</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="请再次输入密码" required>
                    </div>
                    <div class="password-strength-text" id="passwordMatchText"></div>
                </div>
                
                <div class="form-group">
                    <div class="terms-agreement">
                        <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
                        <label for="agreeTerms">
                            我同意 <a href="${pageContext.request.contextPath}/terms.jsp" class="terms-link">服务条款</a> 和 <a href="${pageContext.request.contextPath}/privacy.jsp" class="terms-link">隐私政策</a>，并已阅读 <a href="${pageContext.request.contextPath}/adoption-agreement.jsp" class="terms-link">领养协议</a>
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary auth-btn">
                    <i class="fas fa-user-plus"></i> 注册账号
                </button>
            </form>
            
            <div class="auth-footer">
                <p>已有账号？ <a href="${pageContext.request.contextPath}/login.jsp" class="auth-link">立即登录</a></p>
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
            const registerForm = document.getElementById('registerForm');
            const errorMessage = document.getElementById('errorMessage');
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const passwordStrengthBar = document.getElementById('passwordStrengthBar');
            const passwordStrengthText = document.getElementById('passwordStrengthText');
            const passwordMatchText = document.getElementById('passwordMatchText');
            
            // 密码强度检查
            function checkPasswordStrength(password) {
                let strength = 0;
                
                // 长度检查
                if (password.length >= 8) {
                    strength++;
                    document.getElementById('lengthReq').className = 'requirement valid';
                    document.getElementById('lengthReq').innerHTML = '<i class="fas fa-check-circle"></i> 至少8个字符';
                } else {
                    document.getElementById('lengthReq').className = 'requirement invalid';
                    document.getElementById('lengthReq').innerHTML = '<i class="fas fa-times-circle"></i> 至少8个字符';
                }
                
                // 大写字母检查
                if (/[A-Z]/.test(password)) {
                    strength++;
                    document.getElementById('uppercaseReq').className = 'requirement valid';
                    document.getElementById('uppercaseReq').innerHTML = '<i class="fas fa-check-circle"></i> 至少一个大写字母';
                } else {
                    document.getElementById('uppercaseReq').className = 'requirement invalid';
                    document.getElementById('uppercaseReq').innerHTML = '<i class="fas fa-times-circle"></i> 至少一个大写字母';
                }
                
                // 小写字母检查
                if (/[a-z]/.test(password)) {
                    strength++;
                    document.getElementById('lowercaseReq').className = 'requirement valid';
                    document.getElementById('lowercaseReq').innerHTML = '<i class="fas fa-check-circle"></i> 至少一个小写字母';
                } else {
                    document.getElementById('lowercaseReq').className = 'requirement invalid';
                    document.getElementById('lowercaseReq').innerHTML = '<i class="fas fa-times-circle"></i> 至少一个小写字母';
                }
                
                // 数字检查
                if (/[0-9]/.test(password)) {
                    strength++;
                    document.getElementById('numberReq').className = 'requirement valid';
                    document.getElementById('numberReq').innerHTML = '<i class="fas fa-check-circle"></i> 至少一个数字';
                } else {
                    document.getElementById('numberReq').className = 'requirement invalid';
                    document.getElementById('numberReq').innerHTML = '<i class="fas fa-times-circle"></i> 至少一个数字';
                }
                
                // 更新强度指示器
                let strengthPercent = 0;
                let strengthLevel = '';
                let color = '';
                
                switch(strength) {
                    case 0:
                    case 1:
                        strengthPercent = 25;
                        strengthLevel = '弱';
                        color = '#ff5252';
                        break;
                    case 2:
                        strengthPercent = 50;
                        strengthLevel = '一般';
                        color = '#ffb74d';
                        break;
                    case 3:
                        strengthPercent = 75;
                        strengthLevel = '强';
                        color = '#4caf50';
                        break;
                    case 4:
                        strengthPercent = 100;
                        strengthLevel = '非常强';
                        color = '#2e7d32';
                        break;
                }
                
                passwordStrengthBar.style.width = strengthPercent + '%';
                passwordStrengthBar.style.backgroundColor = color;
                passwordStrengthText.textContent = '密码强度：' + strengthLevel;
                passwordStrengthText.style.color = color;
                
                return strength;
            }
            
            // 密码匹配检查
            function checkPasswordMatch() {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                
                if (confirmPassword === '') {
                    passwordMatchText.textContent = '';
                    return false;
                }
                
                if (password === confirmPassword) {
                    passwordMatchText.textContent = '密码匹配 ✓';
                    passwordMatchText.style.color = '#2e7d32';
                    return true;
                } else {
                    passwordMatchText.textContent = '密码不匹配 ✗';
                    passwordMatchText.style.color = '#d32f2f';
                    return false;
                }
            }
            
            // 事件监听
            passwordInput.addEventListener('input', function() {
                checkPasswordStrength(this.value);
                checkPasswordMatch();
            });
            
            confirmPasswordInput.addEventListener('input', checkPasswordMatch);
            
            // 表单提交验证
            registerForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // 重置错误消息
                errorMessage.style.display = 'none';
                
                // 获取表单值
                const firstName = document.getElementById('firstName').value.trim();
                const lastName = document.getElementById('lastName').value.trim();
                const email = document.getElementById('email').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const username = document.getElementById('username').value.trim();
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                const agreeTerms = document.getElementById('agreeTerms').checked;
                
                // 验证所有字段
                let isValid = true;
                let errorMsg = '';
                
                if (!firstName || !lastName) {
                    isValid = false;
                    errorMsg = '请输入完整的姓名';
                } else if (!email || !/\S+@\S+\.\S+/.test(email)) {
                    isValid = false;
                    errorMsg = '请输入有效的电子邮箱';
                } else if (!phone || !/^1[3-9]\d{9}$/.test(phone)) {
                    isValid = false;
                    errorMsg = '请输入有效的手机号码';
                } else if (!username || username.length < 3) {
                    isValid = false;
                    errorMsg = '用户名至少需要3个字符';
                } else if (checkPasswordStrength(password) < 2) {
                    isValid = false;
                    errorMsg = '密码强度不足，请使用更强的密码';
                } else if (!checkPasswordMatch()) {
                    isValid = false;
                    errorMsg = '两次输入的密码不一致';
                } else if (!agreeTerms) {
                    isValid = false;
                    errorMsg = '请同意服务条款和隐私政策';
                }
                
                if (!isValid) {
                    errorMessage.textContent = errorMsg;
                    errorMessage.style.display = 'block';
                    return;
                }
                
                // 显示加载状态
                const submitBtn = registerForm.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 注册中...';
                submitBtn.disabled = true;
                
                // 模拟注册过程
                setTimeout(function() {
                    // 在实际项目中，这里会发送表单数据到服务器
                    // 模拟成功注册
                    window.location.href = '${pageContext.request.contextPath}/login.jsp?registered=true';
                }, 2000);
            });
            
            // 检查URL参数
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('error') === 'true') {
                errorMessage.style.display = 'block';
            }
        });
    </script>
</body>
</html>