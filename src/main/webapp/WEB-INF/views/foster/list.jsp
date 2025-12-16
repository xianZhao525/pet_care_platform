<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>临时寄养服务 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        .foster-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .foster-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            margin-bottom: 30px;
        }
        .foster-card:hover {
            transform: translateY(-5px);
        }
        .foster-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <jsp:include page="../common/navbar.jsp" />
    
    <div class="foster-hero">
        <div class="container">
            <h1 class="display-4">🐾 临时寄养服务</h1>
            <p class="lead">当您外出时，我们为您提供安全可靠的宠物临时寄养服务</p>
        </div>
    </div>

    <div class="container my-5">
        <div class="row">
            <div class="col-md-4">
                <div class="foster-card">
                    <img src="https://images.unsplash.com/photo-1581888227599-779811939961?w=400" alt="专业寄养">
                    <div class="card-body">
                        <h5>🏠 家庭式寄养</h5>
                        <p>温馨的家庭环境，让您的宠物感受家的温暖</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="foster-card">
                    <img src="https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=400" alt="专业护理">
                    <div class="card-body">
                        <h5>👩‍⚕️ 专业护理</h5>
                        <p>经验丰富的护理人员，24小时贴心照顾</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="foster-card">
                    <img src="https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?w=400" alt="实时监控">
                    <div class="card-body">
                        <h5>📱 实时监控</h5>
                        <p>提供实时视频，随时查看宠物状态</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>