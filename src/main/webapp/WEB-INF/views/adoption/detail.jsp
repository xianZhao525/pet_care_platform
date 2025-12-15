<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pet.name} - 领养详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .pet-detail-img {
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .pet-info-card {
            margin-bottom: 20px;
        }
        .info-label {
            font-weight: bold;
            color: #6c757d;
        }
        .apply-section {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/navbar.jsp" %>

    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/adoption/list">领养宠物</a></li>
                <li class="breadcrumb-item active">${pet.name}</li>
            </ol>
        </nav>

        <div class="row">
            <!-- 宠物图片 -->
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/static/images/pets/${empty pet.image ? 'default.jpg' : pet.image}" 
                     alt="${pet.name}" class="img-fluid pet-detail-img">
            </div>

            <!-- 宠物信息 -->
            <div class="col-md-6">
                <div class="card pet-info-card">
                    <div class="card-body">
                        <h2 class="card-title">${pet.name}</h2>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge ${pet.type == 'DOG' ? 'bg-success' : 'bg-info'} fs-6">
                                ${pet.type == 'DOG' ? '狗狗' : (pet.type == 'CAT' ? '猫咪' : '其他')}
                            </span>
                            <span class="badge ${pet.status == 'AVAILABLE' ? 'bg-primary' : 'bg-secondary'} fs-6">
                                ${pet.status == 'AVAILABLE' ? '可领养' : '已被领养'}
                            </span>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-6">
                                <p class="mb-1"><span class="info-label">品种：</span>${pet.breed}</p>
                            </div>
                            <div class="col-6">
                                <p class="mb-1"><span class="info-label">年龄：</span>${pet.age}岁</p>
                            </div>
                            <div class="col-6">
                                <p class="mb-1"><span class="info-label">性别：</span>${pet.gender == 'MALE' ? '公' : '母'}</p>
                            </div>
                            <div class="col-6">
                                <p class="mb-1"><span class="info-label">健康状况：</span>${pet.healthStatus}</p>
                            </div>
                            <div class="col-6">
                                <p class="mb-1"><span class="info-label">是否绝育：</span>${pet.isNeutered ? '是' : '否'}</p>
                            </div>
                            <div class="col-6">
                                <p class="mb-1"><span class="info-label">是否接种疫苗：</span>${pet.isVaccinated ? '是' : '否'}</p>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <h5 class="mb-3">关于${pet.name}</h5>
                        <p class="card-text">${pet.description}</p>
                        
                        <c:if test="${pet.status == 'AVAILABLE'}">
                            <button class="btn btn-primary btn-lg w-100 mt-3" data-bs-toggle="modal" 
                                    data-bs-target="#applyModal">
                                <i class="fas fa-heart"></i> 申请领养
                            </button>
                        </c:if>
                        
                        <c:if test="${pet.status != 'AVAILABLE'}">
                            <button class="btn btn-secondary btn-lg w-100 mt-3" disabled>
                                已被领养
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- 申请领养弹窗 -->
        <div class="modal fade" id="applyModal" tabindex="-1" aria-labelledby="applyModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="applyModalLabel">申请领养 ${pet.name}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/adoption/apply" method="post" id="applyForm">
                        <input type="hidden" name="petId" value="${pet.id}">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="applicationReason" class="form-label">申请理由 *</label>
                                <textarea class="form-control" id="applicationReason" name="applicationReason" 
                                          rows="3" required placeholder="请说明您为什么想要领养这只宠物"></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="familyEnvironment" class="form-label">家庭环境描述 *</label>
                                <textarea class="form-control" id="familyEnvironment" name="familyEnvironment" 
                                          rows="3" required placeholder="请描述您的居住环境、家庭成员情况等"></textarea>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">是否有养宠经验？ *</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="hasPetExperience" 
                                               id="experienceYes" value="true" required>
                                        <label class="form-check-label" for="experienceYes">
                                            有经验
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="hasPetExperience" 
                                               id="experienceNo" value="false">
                                        <label class="form-check-label" for="experienceNo">
                                            无经验
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="expectedCareTime" class="form-label">预计照顾时间 *</label>
                                    <input type="text" class="form-control" id="expectedCareTime" 
                                           name="expectedCareTime" required placeholder="例如：每天4小时">
                                </div>
                            </div>
                            
                            <div class="alert alert-info">
                                <h6><i class="fas fa-info-circle"></i> 领养须知</h6>
                                <ul class="mb-0">
                                    <li>请确保您有足够的时间和精力照顾宠物</li>
                                    <li>领养需要经过审核，请如实填写信息</li>
                                    <li>领养后需要定期反馈宠物情况</li>
                                    <li>不得随意转让或遗弃宠物</li>
                                </ul>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                            <button type="submit" class="btn btn-primary">提交申请</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 宠物详细信息 -->
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>详细信息</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <h6>生活习性</h6>
                                <p>${empty pet.habits ? '暂无信息' : pet.habits}</p>
                            </div>
                            <div class="col-md-4">
                                <h6>饮食偏好</h6>
                                <p>${empty pet.diet ? '暂无信息' : pet.diet}</p>
                            </div>
                            <div class="col-md-4">
                                <h6>特殊需求</h6>
                                <p>${empty pet.specialNeeds ? '无特殊需求' : pet.specialNeeds}</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-4">
                                <h6>领养要求</h6>
                                <ul>
                                    <li>有固定住所</li>
                                    <li>有稳定的收入</li>
                                    <li>家人同意养宠物</li>
                                    <li>有爱心和责任心</li>
                                </ul>
                            </div>
                            <div class="col-md-8">
                                <h6>领养流程</h6>
                                <ol>
                                    <li>填写领养申请表</li>
                                    <li>等待审核（3-5个工作日）</li>
                                    <li>家访（如需）</li>
                                    <li>签署领养协议</li>
                                    <li>接宠物回家</li>
                                    <li>定期回访</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
    
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/main.js"></script>
    <script>
        $(document).ready(function() {
            $('#applyForm').submit(function(e) {
                if (!checkUserLogin()) {
                    e.preventDefault();
                    alert('请先登录后再申请领养！');
                    window.location.href = '${pageContext.request.contextPath}/user/login?redirect=' + encodeURIComponent(window.location.pathname);
                    return false;
                }
                return true;
            });
            
            function checkUserLogin() {
                // 这里可以检查用户是否登录
                // 实际项目中应该从session中检查
                return true; // 暂时返回true，实际需要实现登录检查
            }
        });
    </script>
</body>
</html>