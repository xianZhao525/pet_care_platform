<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>爱心捐赠 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .donation-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            overflow: hidden;
        }
        .donation-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .donation-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        .donation-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            color: white;
        }
        .status-ongoing { background-color: #28a745; }
        .status-planning { background-color: #6c757d; }
        .status-completed { background-color: #007bff; }
        .status-suspended { background-color: #ffc107; }
        .status-closed { background-color: #dc3545; }
        .progress-bar {
            height: 10px;
            border-radius: 5px;
            overflow: hidden;
        }
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
        }
        .featured-donation {
            border: 2px solid #ffc107;
            box-shadow: 0 0 10px rgba(255,193,7,0.3);
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <!-- 统计数据 -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="stats-card">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <div class="stats-number">${stats.totalProjects}</div>
                            <div>总项目数</div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-number">
                                <fmt:formatNumber value="${stats.totalDonationAmount}" pattern="#,##0.00"/>
                            </div>
                            <div>累计捐赠(元)</div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-number">${stats.totalDonors}</div>
                            <div>爱心人士</div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-number">${stats.activeProjects}</div>
                            <div>进行中项目</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h2 class="mb-3"><i class="fas fa-heart text-danger"></i> 爱心捐赠</h2>
                <p class="text-muted mb-4">您的每一份爱心，都能帮助更多的小动物找到温暖的家</p>
            </div>
        </div>

        <!-- 特色项目 -->
        <c:if test="${not empty featuredDonations}">
            <div class="row mb-4">
                <div class="col-md-12">
                    <h4 class="border-bottom pb-2 mb-3">
                        <i class="fas fa-star text-warning"></i> 特色项目
                    </h4>
                    <div class="row">
                        <c:forEach var="donation" items="${featuredDonations}">
                            <div class="col-md-4">
                                <div class="card donation-card featured-donation">
                                    <div class="position-relative">
                                        <img src="${pageContext.request.contextPath}/static/images/donations/${empty donation.coverImage ? 'default.jpg' : donation.coverImage}" 
                                             alt="${donation.title}" class="card-img-top donation-img">
                                        <span class="donation-status status-${donation.status.toString().toLowerCase()}">
                                            <c:choose>
                                                <c:when test="${donation.status == 'ONGOING'}">进行中</c:when>
                                                <c:when test="${donation.status == 'PLANNING'}">规划中</c:when>
                                                <c:when test="${donation.status == 'COMPLETED'}">已完成</c:when>
                                                <c:when test="${donation.status == 'SUSPENDED'}">已暂停</c:when>
                                                <c:when test="${donation.status == 'CLOSED'}">已关闭</c:when>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">${donation.title}</h5>
                                        <p class="card-text">${donation.description.length() > 60 ? donation.description.substring(0,60) + '...' : donation.description}</p>
                                        
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between mb-1">
                                                <small>筹款进度</small>
                                                <small>
                                                    <fmt:formatNumber value="${donation.currentAmount}" pattern="#,##0.00"/> / 
                                                    <fmt:formatNumber value="${donation.targetAmount}" pattern="#,##0.00"/> 元
                                                </small>
                                            </div>
                                            <div class="progress-bar bg-light">
                                                <div class="progress-bar bg-success" 
                                                     style="width: ${donation.getProgressPercentage()}%"></div>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="badge bg-info">
                                                <c:choose>
                                                    <c:when test="${donation.type == 'MONEY'}">金钱捐赠</c:when>
                                                    <c:when test="${donation.type == 'ITEMS'}">物资捐赠</c:when>
                                                    <c:when test="${donation.type == 'VOLUNTEER'}">志愿服务</c:when>
                                                    <c:when test="${donation.type == 'BOTH'}">综合捐赠</c:when>
                                                </c:choose>
                                            </span>
                                            <a href="${pageContext.request.contextPath}/donation/detail/${donation.id}" 
                                               class="btn btn-sm btn-danger">立即支持</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- 筛选条件 -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/donation/list" method="get" class="row g-3">
                    <div class="col-md-4">
                        <label for="keyword" class="form-label">搜索关键词</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" 
                               value="${param.keyword}" placeholder="输入项目名称或描述">
                    </div>
                    <div class="col-md-3">
                        <label for="type" class="form-label">捐赠类型</label>
                        <select class="form-select" id="type" name="type">
                            <option value="">全部类型</option>
                            <option value="MONEY" ${param.type == 'MONEY' ? 'selected' : ''}>金钱捐赠</option>
                            <option value="ITEMS" ${param.type == 'ITEMS' ? 'selected' : ''}>物资捐赠</option>
                            <option value="VOLUNTEER" ${param.type == 'VOLUNTEER' ? 'selected' : ''}>志愿服务</option>
                            <option value="BOTH" ${param.type == 'BOTH' ? 'selected' : ''}>综合捐赠</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="status" class="form-label">项目状态</label>
                        <select class="form-select" id="status" name="status">
                            <option value="">全部状态</option>
                            <option value="ONGOING" ${param.status == 'ONGOING' ? 'selected' : ''}>进行中</option>
                            <option value="PLANNING" ${param.status == 'PLANNING' ? 'selected' : ''}>规划中</option>
                            <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>已完成</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search"></i> 搜索
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 最新捐赠动态 -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-history"></i> 最新捐赠动态</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach var="donation" items="${recentDonations}">
                                <div class="col-md-3">
                                    <div class="card border-0 shadow-sm mb-3">
                                        <div class="card-body">
                                            <div class="d-flex align-items-start">
                                                <div class="flex-shrink-0">
                                                    <i class="fas ${donation.type == 'MONEY' ? 'fa-money-bill-wave text-success' : 
                                                                donation.type == 'ITEMS' ? 'fa-box text-primary' : 
                                                                'fa-hands-helping text-warning'} fa-2x"></i>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h6 class="mb-1">${donation.donorName}</h6>
                                                    <p class="mb-1">
                                                        <c:choose>
                                                            <c:when test="${donation.type == 'MONEY'}">
                                                                捐赠了 <span class="text-success fw-bold">¥${donation.amount}</span>
                                                            </c:when>
                                                            <c:when test="${donation.type == 'ITEMS'}">
                                                                捐赠了 <span class="text-primary fw-bold">${donation.itemCount}件 ${donation.itemName}</span>
                                                            </c:when>
                                                            <c:when test="${donation.type == 'VOLUNTEER'}">
                                                                贡献了 <span class="text-warning fw-bold">${donation.volunteerHours}小时</span> 志愿服务
                                                            </c:when>
                                                        </c:choose>
                                                    </p>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${donation.donationTime}" pattern="MM-dd HH:mm"/>
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 所有项目 -->
        <div class="row">
            <div class="col-md-12">
                <h4 class="border-bottom pb-2 mb-3">所有项目</h4>
            </div>
        </div>

        <div class="row">
            <c:if test="${empty donations}">
                <div class="col-12 text-center py-5">
                    <i class="fas fa-heart-broken fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">暂无捐赠项目</h4>
                    <p class="text-muted">请尝试其他搜索条件</p>
                </div>
            </c:if>
            
            <c:forEach var="donation" items="${donations}">
                <div class="col-md-4">
                    <div class="card donation-card">
                        <div class="position-relative">
                            <img src="${pageContext.request.contextPath}/static/images/donations/${empty donation.coverImage ? 'default.jpg' : donation.coverImage}" 
                                 alt="${donation.title}" class="card-img-top donation-img">
                            <span class="donation-status status-${donation.status.toString().toLowerCase()}">
                                <c:choose>
                                    <c:when test="${donation.status == 'ONGOING'}">进行中</c:when>
                                    <c:when test="${donation.status == 'PLANNING'}">规划中</c:when>
                                    <c:when test="${donation.status == 'COMPLETED'}">已完成</c:when>
                                    <c:when test="${donation.status == 'SUSPENDED'}">已暂停</c:when>
                                    <c:when test="${donation.status == 'CLOSED'}">已关闭</c:when>
                                </c:choose>
                            </span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${donation.title}</h5>
                            <p class="card-text">${donation.description.length() > 80 ? donation.description.substring(0,80) + '...' : donation.description}</p>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <small>筹款进度</small>
                                    <small>
                                        <fmt:formatNumber value="${donation.currentAmount}" pattern="#,##0.00"/> / 
                                        <fmt:formatNumber value="${donation.targetAmount}" pattern="#,##0.00"/> 元
                                    </small>
                                </div>
                                <div class="progress" style="height: 10px;">
                                    <div class="progress-bar bg-success" 
                                         style="width: ${donation.getProgressPercentage()}%"></div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <small class="text-muted">
                                    <i class="fas fa-users"></i> ${stats.donorCount} 人支持 · 
                                    <c:if test="${donation.getRemainingDays() != null && donation.getRemainingDays() > 0}">
                                        剩余 ${donation.getRemainingDays()} 天
                                    </c:if>
                                </small>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-info">
                                    <c:choose>
                                        <c:when test="${donation.type == 'MONEY'}">金钱捐赠</c:when>
                                        <c:when test="${donation.type == 'ITEMS'}">物资捐赠</c:when>
                                        <c:when test="${donation.type == 'VOLUNTEER'}">志愿服务</c:when>
                                        <c:when test="${donation.type == 'BOTH'}">综合捐赠</c:when>
                                    </c:choose>
                                </span>
                                <a href="${pageContext.request.contextPath}/donation/detail/${donation.id}" 
                                   class="btn btn-sm btn-outline-danger">查看详情</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 分页 -->
        <c:if test="${not empty donations}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pageInfo.pageNum - 1}&keyword=${param.keyword}&type=${param.type}&status=${param.status}">
                                <i class="fas fa-chevron-left"></i> 上一页
                            </a>
                        </li>
                    </c:if>
                    
                    <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                        <li class="page-item ${pageInfo.pageNum == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&keyword=${param.keyword}&type=${param.type}&status=${param.status}">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pageInfo.pageNum + 1}&keyword=${param.keyword}&type=${param.type}&status=${param.status}">
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
</body>
</html>