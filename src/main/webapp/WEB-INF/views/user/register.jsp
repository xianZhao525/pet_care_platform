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
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <a href="${pageContext.request.contextPath}/" class="auth-logo">
                    <i class="fas fa-paw"></i>
                </a>
                <h1 class="auth-title">创建新账号</h1>
                <p class="auth-subtitle">加入我们，为流浪宠物提供一个温暖的家</p>
            </div>
            
            <%-- ✅ 显示后端验证错误（Flash消息） --%>
            <c:if test="${not empty error}">
                <div class="error-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <%-- ✅ 显示表单验证错误汇总 --%>
            <c:if test="${bindingResult.hasErrors()}">
                <div class="error-message" style="display: block; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> 
                    <c:forEach items="${bindingResult.allErrors}" var="error">
                        ${error.defaultMessage}<br>
                    </c:forEach>
                </div>
            </c:if>
            
            <%-- ✅ 注册表单 --%>
            <form id="registerForm" action="${pageContext.request.contextPath}/user/register" method="POST">
                <div class="form-group">
                    <label for="username" class="form-label">用户名 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-user-circle input-icon"></i>
                        <input type="text" id="username" name="username" class="form-control" 
                               value="${userDTO.username}" placeholder="请输入用户名" required autofocus
                               data-error="用户名不能为空，且长度需在3-20位之间">
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="usernameError" style="display: none;"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone" class="form-label">手机号码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-phone input-icon"></i>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               value="${userDTO.phone}" placeholder="请输入手机号码" required
                               data-error="手机号格式不正确，请输入11位手机号码">
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="phoneError" style="display: none;"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">电子邮箱</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" class="form-control" 
                               value="${userDTO.email}" placeholder="请输入电子邮箱">
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="emailError" style="display: none;"></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">密码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="请输入密码（至少6位）" required
                               data-error="密码长度至少为6位">
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="passwordError" style="display: none;"></div>
                    </div>
                    
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
                               placeholder="请再次输入密码" required
                               data-error="两次输入的密码不一致">
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="confirmPasswordError" style="display: none;"></div>
                    </div>
                    <div class="password-strength-text" id="passwordMatchText"></div>
                </div>
                
                <%-- 角色选择 --%>
                <div class="form-group">
                    <label class="form-label">注册身份</label>
                    <div class="role-selection">
                        <label class="role-option">
                            <input type="radio" name="role" value="USER" checked>
                            <span><i class="fas fa-user"></i> 普通用户</span>
                        </label>
                        <label class="role-option">
                            <input type="radio" name="role" value="ADMIN">
                            <span><i class="fas fa-user-shield"></i> 管理员</span>
                        </label>
                    </div>
                </div>
                
                <%-- 管理员注册码 --%>
                <div class="form-group" id="adminCodeGroup" style="display: none;">
                    <label for="adminCode" class="form-label">管理员注册码 <span class="required">*</span></label>
                    <div class="input-with-icon">
                        <i class="fas fa-key input-icon"></i>
                        <input type="password" id="adminCode" name="adminCode" class="form-control" 
                               placeholder="请输入管理员注册码"
                               data-error="管理员注册码不能为空">
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="adminCodeError" style="display: none;"></div>
                    </div>
                    <small class="form-text text-muted">只有管理员才需要填写此项</small>
                </div>
                
                <div class="form-group">
                    <div class="terms-agreement">
                        <input type="checkbox" id="agreeTerms" name="agreeTerms" required
                               data-error="请同意服务条款和隐私政策">
                        <label for="agreeTerms">
                            我已阅读并同意 <a href="${pageContext.request.contextPath}/terms" class="terms-link">服务条款</a> 和 
                            <a href="${pageContext.request.contextPath}/privacy" class="terms-link">隐私政策</a>
                        </label>
                        <%-- 实时错误提示 --%>
                        <div class="error-text" id="agreeTermsError" style="display: none;"></div>
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

    <%@ include file="../common/footer.jsp" %>
    
    <script>
        // 手机号正则表达式
        const PHONE_REGEX = /^1[3-9]\d{9}$/;
        // 邮箱正则表达式
        const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        // 显示错误提示
        function showError(fieldId, message) {
            const errorElement = document.getElementById(fieldId + 'Error');
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        
        // 隐藏错误提示
        function hideError(fieldId) {
            const errorElement = document.getElementById(fieldId + 'Error');
            errorElement.style.display = 'none';
        }
        
        // 验证用户名
        function validateUsername() {
            const username = document.getElementById('username').value.trim();
            if (!username || username.length < 3 || username.length > 20) {
                showError('username', '用户名不能为空，且长度需在3-20位之间');
                return false;
            }
            hideError('username');
            return true;
        }
        
        // ✅ 验证手机号（关键修复）
        function validatePhone() {
            const phone = document.getElementById('phone').value.trim();
            if (!phone) {
                showError('phone', '手机号码不能为空');
                return false;
            }
            if (!PHONE_REGEX.test(phone)) {
                showError('phone', '手机号格式不正确，请输入11位手机号码（如：13812345678）');
                return false;
            }
            hideError('phone');
            return true;
        }
        
        // 验证邮箱
        function validateEmail() {
            const email = document.getElementById('email').value.trim();
            if (email && !EMAIL_REGEX.test(email)) {
                showError('email', '邮箱格式不正确（如：user@example.com）');
                return false;
            }
            hideError('email');
            return true;
        }
        
        // 验证密码
        function validatePassword() {
            const password = document.getElementById('password').value;
            if (!password || password.length < 6) {
                showError('password', '密码长度至少为6位');
                return false;
            }
            hideError('password');
            return true;
        }
        
        // 验证确认密码
        function validateConfirmPassword() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (!confirmPassword) {
                showError('confirmPassword', '请确认密码');
                return false;
            }
            if (password !== confirmPassword) {
                showError('confirmPassword', '两次输入的密码不一致');
                return false;
            }
            hideError('confirmPassword');
            return true;
        }
        
        // 验证条款
        function validateTerms() {
            const agreeTerms = document.getElementById('agreeTerms').checked;
            if (!agreeTerms) {
                showError('agreeTerms', '请同意服务条款和隐私政策');
                return false;
            }
            hideError('agreeTerms');
            return true;
        }
        
        // 验证管理员注册码
        function validateAdminCode() {
            const adminRadio = document.querySelector('input[name="role"][value="ADMIN"]');
            const adminCode = document.getElementById('adminCode').value.trim();
            
            if (adminRadio.checked) {
                if (!adminCode) {
                    showError('adminCode', '管理员注册码不能为空');
                    return false;
                }
                hideError('adminCode');
            }
            return true;
        }

        // 切换管理员注册码输入框
        function toggleAdminCode() {
            const adminRadio = document.querySelector('input[name="role"][value="ADMIN"]');
            const adminCodeGroup = document.getElementById('adminCodeGroup');
            const adminCodeInput = document.getElementById('adminCode');
            
            if (adminRadio && adminRadio.checked) {
                adminCodeGroup.style.display = 'block';
                adminCodeInput.required = true;
            } else {
                adminCodeGroup.style.display = 'none';
                adminCodeInput.required = false;
                adminCodeInput.value = '';
                hideError('adminCode'); // 隐藏错误
            }
        }

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

        document.addEventListener('DOMContentLoaded', function() {
            // 页面加载时执行一次
            toggleAdminCode();
            
            // 为所有输入框添加实时验证
            document.getElementById('username').addEventListener('blur', validateUsername);
            document.getElementById('phone').addEventListener('blur', validatePhone);
            document.getElementById('email').addEventListener('blur', validateEmail);
            document.getElementById('password').addEventListener('blur', validatePassword);
            document.getElementById('confirmPassword').addEventListener('blur', validateConfirmPassword);
            
            // 为radio按钮添加事件监听
            const roleRadios = document.querySelectorAll('input[name="role"]');
            roleRadios.forEach(radio => {
                radio.addEventListener('change', toggleAdminCode);
            });
            
            // 密码强度实时检查
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const passwordStrengthBar = document.getElementById('passwordStrengthBar');
            const passwordStrengthText = document.getElementById('passwordStrengthText');
            const passwordMatchText = document.getElementById('passwordMatchText');
            
            passwordInput.addEventListener('input', function() {
                checkPasswordStrength(this.value);
                // 如果确认密码已填写，也检查匹配
                if (confirmPasswordInput.value) {
                    validateConfirmPassword();
                }
            });
            
            confirmPasswordInput.addEventListener('input', function() {
                // 检查密码匹配
                const password = passwordInput.value;
                const confirmPassword = this.value;
                
                if (!confirmPassword) {
                    passwordMatchText.textContent = '';
                    hideError('confirmPassword');
                } else if (password === confirmPassword) {
                    passwordMatchText.textContent = '密码匹配 ✓';
                    passwordMatchText.style.color = '#2e7d32';
                    hideError('confirmPassword');
                } else {
                    passwordMatchText.textContent = '密码不匹配 ✗';
                    passwordMatchText.style.color = '#d32f2f';
                    showError('confirmPassword', '两次输入的密码不一致');
                }
            });
            
            // 表单提交验证
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                // 执行所有验证
                const isValid = validateUsername() & 
                               validatePhone() & 
                               validateEmail() & 
                               validatePassword() & 
                               validateConfirmPassword() & 
                               validateTerms() & 
                               validateAdminCode();
                
                if (!isValid) {
                    e.preventDefault();
                    alert('请修正表单中的错误后再提交！');
                    return;
                }
                
                // 显示加载状态
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 注册中...';
                submitBtn.disabled = true;
                submitBtn.style.opacity = '0.7';
            });
        });
    </script>
</body>
</html>