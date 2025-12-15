<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>临时寄养 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .foster-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            overflow: hidden;
        }
        .foster-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .foster-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        .foster-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            color: white;
        }
        .status-pending { background-color: #28a745; }
        .status-matched { background-color: #007bff; }
        .status-in-progress { background-color: #ffc107; }
        .status-completed { background-color: #6c757d; }
        .status-canceled { background-color: #dc3545; }
        .filter-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .pet-type-icon {
            font-size: 20px;
            margin-right: 5px;
        }
        .date-badge {
            background: #e9ecef;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <h2 class="mb-3"><i class="fas fa-home text-primary"></i> 临时寄养</h2>
                <p class="text-muted mb-4">为爱宠找到临时的家，或帮助他人照顾宠物</p>
            </div>
        </div>

        <!-- 快速操作 -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="d-flex justify-content-between">
                    <div>
                        <a href="${pageContext.request.contextPath}/foster/create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> 发布寄养需求
                        </a>
                        <a href="${pageContext.request.contextPath}/foster/my-fosters" class="btn btn-outline-primary ms-2">
                            <i class="fas fa-list"></i> 我的寄养
                        </a>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/foster/my-applications" class="btn btn-outline-success">
                            <i class="fas fa-handshake"></i> 我申请的寄养
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 筛选条件 -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/foster/list" method="get" class="row g-3">
                <div class="col-md-3">
                    <label for="city" class="form-label">城市</label>
                    <input type="text" class="form-control" id="city" name="city" 
                           value="${param.city}" placeholder="输入城市名称">
                </div>
                <div class="col-md-2">
                    <label for="petType" class="form-label">宠物类型</label>
                    <select class="form-select" id="petType" name="petType">
                        <option value="">全部</option>
                        <option value="DOG" ${param.petType == 'DOG' ? 'selected' : ''}>狗狗</option>
                        <option value="CAT" ${param.petType == 'CAT' ? 'selected' : ''}>猫咪</option>
                        <option value="OTHER" ${param.petType == 'OTHER' ? 'selected' : ''}>其他</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="startDate" class="form-label">开始日期</label>
                    <input type="date" class="form-control" id="startDate" name="startDate" 
                           value="${param.startDate}">
                </div>
                <div class="col-md-2">
                    <label for="endDate" class="form-label">结束日期</label>
                    <input type="date" class="form-control" id="endDate" name="endDate" 
                           value="${param.endDate}">
                </div>
                <div class="col-md-2">
                    <label for="maxFee" class="form-label">最高费用/天</label>
                    <input type="number" class="form-control" id="maxFee" name="maxFee" 
                           value="${param.maxFee}" placeholder="元" step="0.01" min="0">
                </div>
                <div class="col-md-1 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search"></i> 筛选
                    </button>
                </div>
            </form>
        </div>

        <!-- 寄养需求列表 -->
        <div class="row">
            <c:if test="${empty fosters}">
                <div class="col-12 text-center py-5">
                    <i class="fas fa-home fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">暂无寄养需求</h4>
                    <p class="text-muted">您可以成为第一个发布寄养需求的人</p>
                    <a href="${pageContext.request.contextPath}/foster/create" class="btn btn-primary">发布寄养需求</a>
                </div>
            </c:if>
            
            <c:forEach var="foster" items="${fosters}">
                <div class="col-md-4">
                    <div class="card foster-card">
                        <div class="position-relative">
                            <c:choose>
                                <c:when test="${not empty foster.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/static/images/fosters/${foster.imageUrl}" 
                                         alt="${foster.title}" class="card-img-top foster-img">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/static/images/default-foster.jpg" 
                                         alt="默认图片" class="card-img-top foster-img">
                                </c:otherwise>
                            </c:choose>
                            <span class="foster-status status-${foster.status.toString().toLowerCase()}">
                                <c:choose>
                                    <c:when test="${foster.status == 'PENDING'}">待寄养</c:when>
                                    <c:when test="${foster.status == 'MATCHED'}">已匹配</c:when>
                                    <c:when test="${foster.status == 'IN_PROGRESS'}">寄养中</c:when>
                                    <c:when test="${foster.status == 'COMPLETED'}">已完成</c:when>
                                    <c:when test="${foster.status == 'CANCELED'}">已取消</c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${foster.title}</h5>
                            
                            <div class="mb-2">
                                <span class="pet-type-icon">
                                    <i class="fas ${foster.petType == 'DOG' ? 'fa-dog' : (foster.petType == 'CAT' ? 'fa-cat' : 'fa-paw')}"></i>
                                </span>
                                <span>${foster.petName} | ${foster.petAge}岁 | ${foster.petGender == 'MALE' ? '公' : '母'}</span>
                            </div>
                            
                            <div class="mb-2">
                                <span class="date-badge">
                                    <i class="far fa-calendar"></i> 
                                    <fmt:formatDate value="${foster.startDate}" pattern="MM月dd日"/>
                                </span>
                                <span class="date-badge">
                                    至 <fmt:formatDate value="${foster.endDate}" pattern="MM月dd日"/>
                                </span>
                                <span class="badge bg-info">${foster.durationDays}天</span>
                            </div>
                            
                            <div class="mb-2">
                                <i class="fas fa-map-marker-alt text-muted"></i>
                                <span class="text-muted">${foster.city} · ${foster.address.length() > 20 ? foster.address.substring(0,20) + '...' : foster.address}</span>
                            </div>
                            
                            <div class="mb-3">
                                <c:if test="${foster.dailyFee > 0}">
                                    <span class="text-primary fw-bold">¥${foster.dailyFee}/天</span>
                                </c:if>
                                <c:if test="${foster.dailyFee == 0}">
                                    <span class="text-success fw-bold">免费寄养</span>
                                </c:if>
                            </div>
                            
                            <p class="card-text">${foster.description.length() > 80 ? foster.description.substring(0,80) + '...' : foster.description}</p>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">
                                    <i class="far fa-clock"></i>
                                    <fmt:formatDate value="${foster.createTime}" pattern="yyyy-MM-dd"/>
                                </small>
                                <a href="${pageContext.request.contextPath}/foster/detail/${foster.id}" 
                                   class="btn btn-sm btn-outline-primary">查看详情</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 分页 -->
        <c:if test="${not empty fosters}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pageInfo.pageNum - 1}&city=${param.city}&petType=${param.petType}&startDate=${param.startDate}&endDate=${param.endDate}&maxFee=${param.maxFee}">
                                <i class="fas fa-chevron-left"></i> 上一页
                            </a>
                        </li>
                    </c:if>
                    
                    <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                        <li class="page-item ${pageInfo.pageNum == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&city=${param.city}&petType=${param.petType}&startDate=${param.startDate}&endDate=${param.endDate}&maxFee=${param.maxFee}">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pageInfo.pageNum + 1}&city=${param.city}&petType=${param.petType}&startDate=${param.startDate}&endDate=${param.endDate}&maxFee=${param.maxFee}">
                                下一页 <i class="fas fa-chevron-right"></i>
                            </a>
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
    <script>
        $(document).ready(function() {
            // 自动填充当前日期
            var today = new Date();
            var tomorrow = new Date();
            tomorrow.setDate(today.getDate() + 1);
            
            $('#startDate').attr('min', today.toISOString().split('T')[0]);
            $('#endDate').attr('min', tomorrow.toISOString().split('T')[0]);
            
            // 日期联动
            $('#startDate').change(function() {
                var startDate = $(this).val();
                if (startDate) {
                    var minEndDate = new Date(startDate);
                    minEndDate.setDate(minEndDate.getDate() + 1);
                    $('#endDate').attr('min', minEndDate.toISOString().split('T')[0]);
                }
            });
        });
    </script>
</body>
</html>