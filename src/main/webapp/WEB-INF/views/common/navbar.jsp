<%-- navbar.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%-- 计算当前请求路径 --%>
<c:set var="currentPath" value="${pageContext.request.servletPath}"/>

<%-- 调试信息（可选） --%>
<%-- 当前路径: ${currentPath} --%>
<style>
    .navbar {
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
    }
    .navbar-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        max-width: 1200px;
        margin: 0 auto;
    }
    .logo {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
        text-decoration: none;
        display: flex;
        align-items: center;
    }
    .logo i { margin-right: 10px; }
    .nav-links {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
    }
    .nav-links li { margin: 0 15px; }
    .nav-links a {
        text-decoration: none;
        color: var(--dark-color);
        font-weight: 500;
        padding: 5px 0;
        position: relative;
        transition: color 0.3s ease;
    }
    .nav-links a:hover { color: var(--primary-color); }
    .nav-links a.active {
        color: var(--primary-color);
    }
    .nav-links a.active::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 100%;
        height: 3px;
        background-color: var(--primary-color);
        border-radius: 3px;
    }
    .auth-buttons { display: flex; gap: 10px; }
    .btn {
        padding: 8px 20px;
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        border: 2px solid transparent;
        cursor: pointer;
    }
    .btn-primary {
        background-color: var(--primary-color);
        color: white;
    }
    .btn-outline {
        background-color: transparent;
        color: var(--primary-color);
        border-color: var(--primary-color);
    }
    @media (max-width: 768px) {
        .navbar-container { flex-direction: column; }
        .nav-links { margin: 15px 0; flex-wrap: wrap; justify-content: center; }
        body { padding-top: 120px; }
    }
</style>

<nav class="navbar">
    <div class="container navbar-container">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <i class="fas fa-paw"></i> 宠物领养平台
        </a>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/" class="${currentPath == '/' || currentPath == '/index.jsp' ? 'active' : ''}">首页</a></li>
            <li><a href="${pageContext.request.contextPath}/pet/list" class="${currentPath.startsWith('/pet') ? 'active' : ''}">领养宠物</a></li>
            <li><a href="${pageContext.request.contextPath}/foster/list" class="${currentPath.startsWith('/foster') ? 'active' : ''}">临时寄养</a></li>
            <li><a href="${pageContext.request.contextPath}/donation/list" class="${currentPath.startsWith('/donation') ? 'active' : ''}">爱心捐赠</a></li>
            <li><a href="${pageContext.request.contextPath}/about" class="${currentPath == '/about' ? 'active' : ''}">关于我们</a></li>
        </ul>
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="btn btn-outline">欢迎，${sessionScope.user.username}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">登录</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="main-content">