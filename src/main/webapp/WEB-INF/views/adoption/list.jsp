<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>领养宠物 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .pet-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .pet-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .pet-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        .pet-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
        }
        .status-available { background-color: #28a745; color: white; }
        .status-pending { background-color: #ffc107; color: black; }
        .status-adopted { background-color: #6c757d; color: white; }
        .filter-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <h2 class="mb-4">领养宠物</h2>
                <p class="text-muted">请查看以下待领养的宠物，给它们一个温暖的家</p>
            </div>
        </div>

        <!-- 筛选条件 -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/adoption/list" method="get" class="row g-3">
                <div class="col-md-3">
                    <label for="type" class="form-label">宠物类型</label>
                    <select class="form-select" id="type" name="type">
                        <option value="">全部</option>
                        <option value="DOG" ${param.type == 'DOG' ? 'selected' : ''}>狗狗</option>
                        <option value="CAT" ${param.type == 'CAT' ? 'selected' : ''}>猫咪</option>
                        <option value="OTHER" ${param.type == 'OTHER' ? 'selected' : ''}>其他</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="age" class="form-label">年龄</label>
                    <select class="form-select" id="age" name="age">
                        <option value="">全部</option>
                        <option value="0-1" ${param.age == '0-1' ? 'selected' : ''}>1岁以下</option>
                        <option value="1-3" ${param.age == '1-3' ? 'selected' : ''}>1-3岁</option>
                        <option value="3-5" ${param.age == '3-5' ? 'selected' : ''}>3-5岁</option>
                        <option value="5+" ${param.age == '5+' ? 'selected' : ''}>5岁以上</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="gender" class="form-label">性别</label>
                    <select class="form-select" id="gender" name="gender">
                        <option value="">全部</option>
                        <option value="MALE" ${param.gender == 'MALE' ? 'selected' : ''}>公</option>
                        <option value="FEMALE" ${param.gender == 'FEMALE' ? 'selected' : ''}>母</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">筛选</button>
                </div>
            </form>
        </div>

        <!-- 宠物列表 -->
        <div class="row">
            <c:if test="${empty pets}">
                <div class="col-12 text-center py-5">
                    <i class="fas fa-paw fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">暂无待领养的宠物</h4>
                    <p class="text-muted">请稍后再来查看</p>
                </div>
            </c:if>
            
            <c:forEach var="pet" items="${pets}">
                <div class="col-md-4 col-lg-3">
                    <div class="card pet-card">
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}/static/images/pets/${empty pet.image ? 'default.jpg' : pet.image}" 
                                 alt="${pet.name}" class="card-img-top pet-img">
                            <span class="pet-status status-${pet.status == 'AVAILABLE' ? 'available' : 'adopted'}">
                                ${pet.status == 'AVAILABLE' ? '可领养' : '已领养'}
                            </span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${pet.name}</h5>
                            <p class="card-text">
                                <small class="text-muted">
                                    <i class="fas ${pet.type == 'DOG' ? 'fa-dog' : 'fa-cat'}"></i>
                                    ${pet.type == 'DOG' ? '狗狗' : (pet.type == 'CAT' ? '猫咪' : '其他')} | 
                                    ${pet.age}岁 | 
                                    ${pet.gender == 'MALE' ? '公' : '母'}
                                </small>
                            </p>
                            <p class="card-text">${pet.description.length() > 50 ? pet.description.substring(0,50) + '...' : pet.description}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-info">${pet.breed}</span>
                                <a href="${pageContext.request.contextPath}/adoption/detail/${pet.id}" 
                                   class="btn btn-sm btn-outline-primary">查看详情</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 分页 -->
        <c:if test="${not empty pets}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pageInfo.pageNum - 1}&type=${param.type}&age=${param.age}&gender=${param.gender}">上一页</a>
                        </li>
                    </c:if>
                    
                    <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                        <li class="page-item ${pageInfo.pageNum == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&type=${param.type}&age=${param.age}&gender=${param.gender}">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pageInfo.pageNum + 1}&type=${param.type}&age=${param.age}&gender=${param.gender}">下一页</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>

    <%@ include file="../common/footer.jsp" %>
    
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>
</html>