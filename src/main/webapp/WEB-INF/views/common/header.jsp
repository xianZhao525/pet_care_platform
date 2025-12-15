<%-- header.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 获取当前路径，用于高亮菜单
    String currentPath = request.getRequestURI();
    String contextPath = request.getContextPath();
    String relativePath = currentPath.substring(contextPath.length());
    
    request.setAttribute("currentPath", relativePath);
    request.setAttribute("ctx", contextPath);
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宠物领养平台</title>
    
    <!-- 统一使用CDN资源 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/css/style.css">
    
    <style>
        :root {
            --primary-color: #4e97fd;
            --secondary-color: #ff7e5f;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }
        body {
            font-family: 'Poppins', sans-serif;
            padding-top: 80px;
        }
    </style>
</head>
<body>