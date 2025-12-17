<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>爱心捐赠 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        .donation-hero {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .donation-stats {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin: -50px auto 50px;
            max-width: 800px;
            position: relative;
            z-index: 10;
        }
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <jsp:include page="../common/navbar.jsp" />
    
    <div class="donation-hero">
        <div class="container">
            <h1 class="display-4">❤️ 爱心捐赠</h1>
            <p class="lead">每一份爱心，都能为流浪动物带来希望</p>
        </div>
    </div>

    <div class="container">
        <div class="donation-stats">
            <div class="row">
                <div class="col-md-4 stat-item">
                    <div class="stat-number">¥128,560</div>
                    <div>累计捐款</div>
                </div>
                <div class="col-md-4 stat-item">
                    <div class="stat-number">1,256</div>
                    <div>爱心人士</div>
                </div>
                <div class="col-md-4 stat-item">
                    <div class="stat-number">342</div>
                    <div>获救动物</div>
                </div>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row">
            <div class="col-md-6">
                <div class="card h-100">
                    <img src="https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?w=500" class="card-img-top" alt="物资捐赠">
                    <div class="card-body">
                        <h5 class="card-title">📦 物资捐赠</h5>
                        <p class="card-text">捐赠宠物粮食、用品、药品等物资</p>
                        <a href="#" class="btn btn-primary">我要捐赠物资</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card h-100">
                    <img src="https://ts3.tc.mm.bing.net/th/id/OIP-C.6djlxUWf3kcBW1LioT5rwAHaHa?cb=ucfimg2&ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3" class="card-img-top" alt="资金捐赠">
                    <div class="card-body">
                        <h5 class="card-title">💰 资金捐赠</h5>
                        <p class="card-text">直接捐款支持流浪动物救助工作</p>
                        <a href="#" class="btn btn-primary">我要捐款</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>