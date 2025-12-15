<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的领养申请 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .application-card {
            margin-bottom: 20px;
            border-left: 4px solid;
        }
        .status-pending { border-left-color: #ffc107; }
        .status-approved { border-left-color: #28a745; }
        .status-rejected { border-left-color: #dc3545; }
        .status-completed { border-left-color: #007bff; }
        .status-canceled { border-left-color: #6c757d; }
        .status-badge {
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 14px;
        }
        .badge-pending { background-color: #ffc107; color: black; }
        .badge-approved { background-color: #28a745; color: white; }
        .badge-rejected { background-color: #dc3545; color: white; }
        .badge-completed { background-color: #007bff; color: white; }
        .badge-canceled { background-color: #6c757d; color: white; }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/navbar.jsp" %>
    
    <c:if test="${empty sessionScope.user}">
        <script>
            window.location.href = "${pageContext.request.contextPath}/user/login";
        </script>
    </c:if>

    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/user/dashboard">用户中心</a></li>
                <li class="breadcrumb-item active">我的领养申请</li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-md-3">
                <%@ include file="../user/sidebar.jsp" %>
            </div>
            
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0">我的领养申请</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty applications}">
                            <div class="text-center py-5">
                                <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">暂无领养申请</h5>
                                <p class="text-muted">快去领养一只可爱的宠物吧！</p>
                                <a href="${pageContext.request.contextPath}/adoption/list" class="btn btn-primary">去领养</a>
                            </div>
                        </c:if>
                        
                        <c:forEach var="app" items="${applications}">
                            <div class="card application-card status-${app.status.toString().toLowerCase()}">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <img src="${pageContext.request.contextPath}/static/images/pets/${empty app.pet.image ? 'default.jpg' : app.pet.image}" 
                                                 alt="${app.pet.name}" class="img-fluid rounded">
                                        </div>
                                        <div class="col-md-7">
                                            <h5>${app.pet.name}</h5>
                                            <p class="text-muted mb-2">
                                                品种：${app.pet.breed} | 
                                                年龄：${app.pet.age}岁 | 
                                                性别：${app.pet.gender == 'MALE' ? '公' : '母'}
                                            </p>
                                            <p><strong>申请理由：</strong>${app.applicationReason}</p>
                                            <p><strong>申请时间：</strong>${app.applicationDate}</p>
                                            <c:if test="${not empty app.reviewDate}">
                                                <p><strong>审核时间：</strong>${app.reviewDate}</p>
                                            </c:if>
                                            <c:if test="${not empty app.reviewNotes}">
                                                <p><strong>审核意见：</strong>${app.reviewNotes}</p>
                                            </c:if>
                                        </div>
                                        <div class="col-md-3 text-end">
                                            <span class="status-badge badge-${app.status.toString().toLowerCase()}">
                                                <c:choose>
                                                    <c:when test="${app.status == 'PENDING'}">待审核</c:when>
                                                    <c:when test="${app.status == 'APPROVED'}">已批准</c:when>
                                                    <c:when test="${app.status == 'REJECTED'}">已拒绝</c:when>
                                                    <c:when test="${app.status == 'COMPLETED'}">已完成</c:when>
                                                    <c:when test="${app.status == 'CANCELED'}">已取消</c:when>
                                                </c:choose>
                                            </span>
                                            <div class="mt-3">
                                                <a href="${pageContext.request.contextPath}/adoption/detail/${app.pet.id}" 
                                                   class="btn btn-sm btn-outline-primary">查看宠物</a>
                                                <c:if test="${app.status == 'PENDING'}">
                                                    <button class="btn btn-sm btn-outline-danger mt-1" 
                                                            onclick="cancelApplication(${app.id})">取消申请</button>
                                                </c:if>
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

    <%@ include file="../common/footer.jsp" %>
    
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
        function cancelApplication(applicationId) {
            if (confirm('确定要取消这个领养申请吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/adoption/cancel',
                    type: 'POST',
                    data: { id: applicationId },
                    success: function(response) {
                        if (response.success) {
                            alert('申请已取消');
                            location.reload();
                        } else {
                            alert('取消失败：' + response.message);
                        }
                    },
                    error: function() {
                        alert('请求失败，请稍后重试');
                    }
                });
            }
        }
    </script>
</body>
</html>