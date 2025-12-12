<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宠物领养平台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .hero-section { background: #f8f9fa; padding: 60px 0; }
        .service-card { border: none; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .pet-card { transition: transform 0.3s; }
        .pet-card:hover { transform: translateY(-5px); }
    </style>
</head>
<body>
    <%@ include file="common/header.jsp" %>
    
    <!-- 首页横幅 -->
    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="display-4">给流浪宠物一个温暖的家</h1>
                    <p class="lead">我们连接爱心人士与需要帮助的宠物，让领养变得简单、可靠</p>
                    <a href="/pet/list" class="btn btn-primary btn-lg mt-3">
                        <i class="fas fa-paw"></i> 浏览待领养宠物
                    </a>
                </div>
                <div class="col-md-6">
                    <img src="/images/hero-pet.jpg" alt="宠物" class="img-fluid rounded">
                </div>
            </div>
        </div>
    </div>
    
    <!-- 特色服务 -->
    <div class="container my-5">
        <h2 class="text-center mb-4">我们的服务</h2>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card service-card text-center">
                    <div class="card-body">
                        <i class="fas fa-home fa-3x text-primary mb-3"></i>
                        <h3>宠物领养</h3>
                        <p>为流浪动物寻找永久的家，提供完整的领养流程支持</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card service-card text-center">
                    <div class="card-body">
                        <i class="fas fa-hands-helping fa-3x text-success mb-3"></i>
                        <h3>临时寄养</h3>
                        <p>为宠物主人提供可靠的临时寄养服务</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card service-card text-center">
                    <div class="card-body">
                        <i class="fas fa-heart fa-3x text-danger mb-3"></i>
                        <h3>爱心捐赠</h3>
                        <p>支持我们的救助工作，帮助更多小生命</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 待领养宠物 -->
    <div class="container my-5">
        <h2 class="text-center mb-4">待领养宠物</h2>
        <div class="row">
            <c:forEach items="${pets}" var="pet" end="5">
                <div class="col-md-4 mb-4">
                    <div class="card pet-card">
                        <img src="/images/pets/${pet.imageUrl}" class="card-img-top" alt="${pet.name}">
                        <div class="card-body">
                            <h5 class="card-title">${pet.name}</h5>
                            <p class="card-text">
                                <i class="fas fa-paw"></i> ${pet.type} | 
                                <i class="fas fa-venus-mars"></i> ${pet.gender} | 
                                <i class="fas fa-birthday-cake"></i> ${pet.age}岁
                            </p>
                            <p class="card-text">${pet.description.substring(0, Math.min(50, pet.description.length()))}...</p>
                            <a href="/pet/detail?id=${pet.id}" class="btn btn-outline-primary">查看详情</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="text-center mt-4">
            <a href="/pet/list" class="btn btn-primary">查看更多宠物</a>
        </div>
    </div>
    
    <%@ include file="common/footer.jsp" %>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <%-- <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/main.js"></script> --%>
</body>
</html>