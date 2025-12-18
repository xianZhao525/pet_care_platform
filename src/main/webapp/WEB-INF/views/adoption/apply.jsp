<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<%
    String ctx = request.getContextPath();
%>
<%
    System.out.println("========== APPLY.JSP DEBUG ==========");
    System.out.println("Context Path: " + request.getContextPath());
    System.out.println("EL Available: " + (pageContext.getExpressionEvaluator() != null));
%>
<!DOCTYPE html>
<html>
<head>
    <title>申请领养 - 宠物领养平台</title>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"> --%>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="/pet_care_platform/static/css/bootstrap.min.css"> --%>

    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=ctx%>/static/css/style.css">
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/navbar.jsp" %>

    <div style="display:none;">
        Context Path: [${pageContext.request.contextPath}]
        EL Works: ${'test'}
    </div>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">领养申请</h4>
                    </div>
                    <div class="card-body">
                        <%-- 显示错误信息 --%>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                错误：${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">
                                ${success}
                                <p>您的申请已提交，审核结果将在3-5个工作日内通知您。</p>
                                <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-success mt-2">查看我的申请</a>
                            </div>
                        </c:if>
                        
                        <c:if test="${empty success}">
                            <%-- <form action="${pageContext.request.contextPath}/adoption/apply" method="post"> --%>
                            <form action="<%=ctx%>/adoption/apply" method="post">
                                <input type="hidden" name="petId" value="${pet.id}">
                                
                                <div class="mb-4 text-center">
                                    <h5>您正在申请领养</h5>
                                    <h3 class="text-primary">${pet.name}</h3>
                                    <%-- <img src="${pageContext.request.contextPath}/static/images/pets/${empty pet.image ? 'default.jpg' : pet.image}" 
                                         alt="${pet.name}" class="img-fluid rounded" style="max-height: 200px;"> --%>
                                    <img src="<%=ctx%>/static/images/pets/${empty pet.image ? 'default.jpg' : pet.image}"
                                        alt="${pet.name}" class="img-fluid rounded" style="max-height: 200px;">
                                    <p class="mt-2">
                                        <span class="badge bg-info">${pet.breed}</span>
                                        <span class="badge bg-secondary">${pet.age}岁</span>
                                        <span class="badge bg-secondary">${pet.gender == 'MALE' ? '公' : '母'}</span>
                                    </p>
                                </div>
                                
                                <h5 class="border-bottom pb-2 mb-3">申请人信息</h5>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">姓名</label>
                                        <input type="text" class="form-control" value="${username}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">联系方式</label>
                                        <input type="text" class="form-control" value="${user.phone}" readonly>
                                    </div>
                                </div>
                                
                                <h5 class="border-bottom pb-2 mb-3">领养申请信息</h5>
                                
                                <div class="mb-3">
                                    <label for="applicationReason" class="form-label">申请理由 <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="applicationReason" name="applicationReason" 
                                              rows="4" required placeholder="请详细说明您为什么想要领养这只宠物...">${application.applicationReason}</textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="familyEnvironment" class="form-label">家庭环境 <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="familyEnvironment" name="familyEnvironment" 
                                              rows="4" required placeholder="请描述您的居住环境（如房屋面积、是否有院子等）、家庭成员情况...">${application.familyEnvironment}</textarea>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">是否有养宠经验？ <span class="text-danger">*</span></label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="hasPetExperience" 
                                                   id="experienceYes" value="true" ${application.hasPetExperience ? 'checked' : ''} required>
                                            <label class="form-check-label" for="experienceYes">
                                                有，曾经养过宠物
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="hasPetExperience" 
                                                   id="experienceNo" value="false" ${not application.hasPetExperience ? 'checked' : ''}>
                                            <label class="form-check-label" for="experienceNo">
                                                没有，这是第一次养宠物
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="expectedCareTime" class="form-label">预计每天照顾时间 <span class="text-danger">*</span></label>
                                        <select class="form-select" id="expectedCareTime" name="expectedCareTime" required>
                                            <option value="">请选择</option>
                                            <option value="少于1小时" ${application.expectedCareTime == '少于1小时' ? 'selected' : ''}>少于1小时</option>
                                            <option value="1-2小时" ${application.expectedCareTime == '1-2小时' ? 'selected' : ''}>1-2小时</option>
                                            <option value="2-4小时" ${application.expectedCareTime == '2-4小时' ? 'selected' : ''}>2-4小时</option>
                                            <option value="4小时以上" ${application.expectedCareTime == '4小时以上' ? 'selected' : ''}>4小时以上</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">您是否了解并同意以下领养条款？ <span class="text-danger">*</span></label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                        <label class="form-check-label" for="agreeTerms">
                                            我确认已阅读并同意<a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">《领养协议》</a>
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">提交申请</button>
                                    <%-- <a href="${pageContext.request.contextPath}/adoption/detail/${pet.id}" class="btn btn-outline-secondary">返回</a> --%>
                                    <a href="<%=ctx%>/adoption/detail/${pet.id}" class="btn btn-outline-secondary">返回</a>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 条款弹窗 -->
    <div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="termsModalLabel">领养协议</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h6>一、领养人责任</h6>
                    <p>1. 保证为领养宠物提供适宜的饮食、住所和医疗照顾。</p>
                    <p>2. 保证不虐待、不遗弃领养宠物。</p>
                    <p>3. 定期接受平台回访，及时反馈宠物情况。</p>
                    
                    <h6 class="mt-3">二、领养要求</h6>
                    <p>1. 领养人需年满18周岁，有固定住所。</p>
                    <p>2. 家庭成员均同意领养宠物。</p>
                    <p>3. 有稳定的经济来源。</p>
                    
                    <h6 class="mt-3">三、其他条款</h6>
                    <p>1. 不得将宠物用于商业用途。</p>
                    <p>2. 如需转让宠物，需提前告知平台。</p>
                    <p>3. 平台有权在发现不适当照顾时收回宠物。</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
    
    <%-- <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script> --%>

    <script src="<%=ctx%>/static/js/jquery.min.js"></script>
    <script src="<%=ctx%>/static/js/bootstrap.min.js"></script>
</body>
</html>