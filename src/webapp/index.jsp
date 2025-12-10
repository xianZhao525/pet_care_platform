<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宠物领养与寄养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- 头部导航 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <!-- 轮播图 -->
    <div id="carouselExample" class="carousel slide mb-4" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/static/images/banner1.jpg" class="d-block w-100" alt="宠物领养">
                <div class="carousel-caption d-none d-md-block">
                    <h2>给流浪宠物一个温暖的家</h2>
                    <p>领养代替购买，让爱不再流浪</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/static/images/banner2.jpg" class="d-block w-100" alt="宠物寄养">
                <div class="carousel-caption d-none d-md-block">
                    <h2>专业宠物寄养服务</h2>
                    <p>让您的爱宠在您外出时得到最好的照顾</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 主要内容区 -->
    <div class="container">
        <!-- 搜索栏 -->
        <div class="row mb-4">
            <div class="col-md-8 offset-md-2">
                <form action="${pageContext.request.contextPath}/pet/search" method="get" class="input-group">
                    <input type="text" class="form-control" name="keyword" placeholder="搜索宠物名称、品种或地点...">
                    <select class="form-select" name="type" style="max-width: 150px;">
                        <option value="">所有类型</option>
                        <option value="DOG">狗狗</option>
                        <option value="CAT">猫咪</option>
                        <option value="OTHER">其他</option>
                    </select>
                    <button class="btn btn-primary" type="submit">
                        <i class="fas fa-search"></i> 搜索
                    </button>
                </form>
            </div>
        </div>
        
        <!-- 特色功能 -->
        <div class="row mb-5">
            <div class="col-md-4 text-center">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body">
                        <i class="fas fa-paw fa-3x text-primary mb-3"></i>
                        <h4 class="card-title">宠物领养</h4>
                        <p class="card-text">浏览待领养宠物，选择您心仪的伙伴，完成领养申请流程。</p>
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-primary">浏览宠物</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body">
                        <i class="fas fa-home fa-3x text-success mb-3"></i>
                        <h4 class="card-title">宠物寄养</h4>
                        <p class="card-text">为您的宠物寻找临时寄养家庭，或成为寄养家庭帮助他人。</p>
                        <a href="${pageContext.request.contextPath}/foster/list" class="btn btn-outline-success">寄养服务</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-body">
                        <i class="fas fa-heart fa-3x text-danger mb-3"></i>
                        <h4 class="card-title">爱心捐赠</h4>
                        <p class="card-text">支持流浪动物救助站，为小动物们提供食物和医疗帮助。</p>
                        <a href="${pageContext.request.contextPath}/donation" class="btn btn-outline-danger">我要捐赠</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 最新待领养宠物 -->
        <div class="row">
            <div class="col-12">
                <h3 class="mb-4">最新待领养宠物</h3>
            </div>
            <c:forEach var="pet" items="${recentPets}">
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="card pet-card h-100">
                        <img src="${pageContext.request.contextPath}/static/images/pets/${pet.imageUrl}"
                             class="card-img-top" alt="${pet.name}">
                        <div class="card-body">
                            <h5 class="card-title">${pet.name}</h5>
                            <p class="card-text">
                                <span class="badge bg-${pet.type == 'DOG' ? 'primary' : 'info'}">${pet.type}</span>
                                <span class="badge bg-secondary">${pet.age}岁</span>
                            </p>
                            <p class="card-text text-truncate">${pet.description}</p>
                            <a href="${pageContext.request.contextPath}/pet/detail?id=${pet.id}" 
                               class="btn btn-sm btn-outline-primary">查看详情</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- 页脚 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>
</html>