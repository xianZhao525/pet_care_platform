<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    
</head>
<body>
    <%-- 引入公共导航栏 --%>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <%-- 在 auth-header 下方添加 --%>

                <%-- 显示Flash错误消息 --%>
                <c:if test="${not empty error}">
                    <div class="error-message" style="display: block; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <%-- 显示表单验证错误 --%>
                <c:if test="${bindingResult.hasErrors()}">
                    <div class="error-message" style="display: block; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-circle"></i> 请检查表单输入
                    </div>
                </c:if>
                <a href="${pageContext.request.contextPath}/" class="auth-logo">
                    <i class="fas fa-paw"></i>
                </a>
                <h1 class="auth-title">创建新账号</h1>
                <p class="auth-subtitle">加入我们，为流浪宠物提供一个温暖的家</p>
            </div>
            
            <%-- 显示注册错误消息（Flash属性） --%>
            <c:if test="${not empty error}">
                <div class="error-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <%-- 显示表单验证错误 --%>
            <c:if test="${bindingResult.hasErrors()}">
                <div class="error-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> 请检查表单输入
                </div>
            </c:if>
            
            <%-- 注册表单 --%>
            <form id="registerForm" action="${pageContext.request.contextPath}/user/register" method="POST">
                <div class="form-group">
                    <label for="username" class="form-label">用户名 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-user-circle input-icon"></i>
                        <input type="text" id="username" name="username" class="form-control" 
                               value="${userDTO.username}" placeholder="请输入用户名" required autofocus>
                    </div>
                    <%-- 显示用户名验证错误 --%>
                    <c:if test="${bindingResult.hasFieldErrors('username')}">
                        <div class="error-text">${bindingResult.getFieldError('username').defaultMessage}</div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="phone" class="form-label">手机号码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-phone input-icon"></i>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               value="${userDTO.phone}" placeholder="请输入手机号码" required>
                    </div>
                    <%-- 显示手机号验证错误 --%>
                    <c:if test="${bindingResult.hasFieldErrors('phone')}">
                        <div class="error-text">${bindingResult.getFieldError('phone').defaultMessage}</div>
                    </c:if>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">电子邮箱</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" class="form-control" 
                               value="${userDTO.email}" placeholder="请输入电子邮箱（可选）">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">密码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="请输入密码（至少6位）" required>
                    </div>
                    <%-- 显示密码验证错误 --%>
                    <c:if test="${bindingResult.hasFieldErrors('password')}">
                        <div class="error-text">${bindingResult.getFieldError('password').defaultMessage}</div>
                    </c:if>
                    
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <div class="password-strength-text" id="passwordStrengthText">密码强度：未输入</div>
                    
                    <div class="password-requirements">
                        <div class="requirement invalid" id="lengthReq">
                            <i class="fas fa-times-circle"></i> 至少6个字符
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
                    <label for="confirmPassword" class="form-label">确认密码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                               placeholder="请再次输入密码" required>
                    </div>
                    <div class="password-strength-text" id="passwordMatchText"></div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">注册身份</label>
                    <div class="role-selection">
                        <label class="role-option">
                            <input type="radio" name="role" value="USER" checked onchange="toggleAdminCode()">
                            <span><i class="fas fa-user"></i> 普通用户</span>
                        </label>
                        <label class="role-option">
                            <input type="radio" name="role" value="ADMIN" onchange="toggleAdminCode()">
                            <span><i class="fas fa-user-shield"></i> 管理员</span>
                        </label>
                    </div>
                </div>

                <div class="form-group" id="adminCodeGroup" style="display: none;">
                    <label for="adminCode" class="form-label">管理员注册码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-key input-icon"></i>
                        <input type="password" id="adminCode" name="adminCode" class="form-control" 
                            placeholder="请输入管理员注册码">
                    </div>
                    <small class="form-text text-muted">只有管理员才需要填写此项</small>
                </div>

                <div class="form-group">
                    <div class="terms-agreement">
                        <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
                        <label for="agreeTerms">
                            我已阅读并同意 <a href="${pageContext.request.contextPath}/terms" class="terms-link">服务条款</a> 和 
                            <a href="${pageContext.request.contextPath}/privacy" class="terms-link">隐私政策</a>
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary auth-btn">
                    <i class="fas fa-user-plus"></i> 注册账号
                </button>
            </form>
            
            <div class="auth-footer">
                <p>已有账号？ <a href="${pageContext.request.contextPath}/user/login" class="auth-link">立即登录</a></p>
            </div>
        </div>
    </div>

    <%-- 引入公共页脚 --%>
    <%-- <%@ include file="../common/footer.jsp" %> --%>
    
    <script>
        // 切换管理员注册码输入框显示/隐藏
        function toggleAdminCode() {
            const adminRadio = document.querySelector('input[name="role"][value="ADMIN"]');
            const adminCodeGroup = document.getElementById('adminCodeGroup');
            const adminCodeInput = document.getElementById('adminCode');
            
            if (adminRadio.checked) {
                adminCodeGroup.style.display = 'block';
                adminCodeInput.required = true;
            } else {
                adminCodeGroup.style.display = 'none';
                adminCodeInput.required = false;
                adminCodeInput.value = ''; 
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            toggleAdminCode();
        
            // ✅ 为radio按钮添加事件监听
            const roleRadios = document.querySelectorAll('input[name="role"]');
            roleRadios.forEach(radio => {
                radio.addEventListener('change', toggleAdminCode);
            });

            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const passwordStrengthBar = document.getElementById('passwordStrengthBar');
            const passwordStrengthText = document.getElementById('passwordStrengthText');
            const passwordMatchText = document.getElementById('passwordMatchText');
            
            // 密码强度检查
            function checkPasswordStrength(password) {
                if (!password) {
                    passwordStrengthText.textContent = '密码强度：未输入';
                    passwordStrengthBar.style.width = '0%';
                    return 0;
                }
                
                let strength = 0;
                
                // 长度检查（至少6位）
                if (password.length >= 6) {
                    strength++;
                    document.getElementById('lengthReq').className = 'requirement valid';
                    document.getElementById('lengthReq').innerHTML = '<i class="fas fa-check-circle"></i> 至少6个字符';
                } else {
                    document.getElementById('lengthReq').className = 'requirement invalid';
                    document.getElementById('lengthReq').innerHTML = '<i class="fas fa-times-circle"></i> 至少6个字符';
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
                const strengthPercent = (strength / 4) * 100;
                let strengthLevel = '';
                let color = '';
                
                switch(strength) {
                    case 0:
                        strengthLevel = '未输入';
                        color = '#ccc';
                        break;
                    case 1:
                        strengthLevel = '弱';
                        color = '#ff5252';
                        break;
                    case 2:
                        strengthLevel = '一般';
                        color = '#ffb74d';
                        break;
                    case 3:
                        strengthLevel = '强';
                        color = '#4caf50';
                        break;
                    case 4:
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
                
                if (!confirmPassword) {
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
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                const agreeTerms = document.getElementById('agreeTerms').checked;
                const adminRadio = document.querySelector('input[name="role"][value="ADMIN"]');
                
                // 验证密码强度
                if (checkPasswordStrength(password) < 2) {
                    e.preventDefault();
                    alert('密码强度不足，请使用更强的密码');
                    return;
                }
                
                // 验证密码匹配
                if (!checkPasswordMatch()) {
                    e.preventDefault();
                    alert('两次输入的密码不一致');
                    return;
                }
                
                // 验证条款同意
                if (!agreeTerms) {
                    e.preventDefault();
                    alert('请先同意服务条款和隐私政策');
                    return;
                }

                // 验证管理员注册码
                if (adminRadio.checked) {
                    const adminCode = document.getElementById('adminCode').value.trim();
                    if (!adminCode) {
                        e.preventDefault();
                        alert('请输入管理员注册码');
                        return;
                    }
                }
                
                // 显示加载状态
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 注册中...';
                submitBtn.disabled = true;
                submitBtn.style.opacity = '0.7';
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