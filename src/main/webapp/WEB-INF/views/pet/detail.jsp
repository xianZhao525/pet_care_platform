<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${pet.name} - 宠物详情</title>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <jsp:include page="../common/navbar.jsp" />
    
    <div class="container my-5">
        <div class="row">
            <div class="col-md-6">
                <img src="${ctx}/images/pets/${pet.imageUrl}" class="img-fluid" alt="${pet.name}">
            </div>
            <div class="col-md-6">
                <h1>${pet.name}</h1>
                <p>品种：${pet.breed}</p>
                <p>年龄：${pet.age}岁</p>
                <p>性别：${pet.gender}</p>
                <p>${pet.description}</p>
                <c:if test="${pet.status == 'AVAILABLE'}">
                    <a href="${ctx}/adoption/apply/${pet.id}" class="btn btn-success">申请领养</a>
                </c:if>
                <%-- 在申请领养按钮下方添加权限提示 --%>
                <div style="margin-top: 10px;">
                    <c:if test="${empty sessionScope.user}">
                        <div class="alert alert-warning">
                            <i class="fas fa-info-circle"></i> 请先 <a href="${ctx}/user/login">登录</a> 后再申请领养
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>