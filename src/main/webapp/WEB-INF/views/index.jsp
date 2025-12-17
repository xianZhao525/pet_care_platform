<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 1. 包含文档头部 -->
<%@ include file="common/header.jsp" %>

<!-- 2. 包含导航栏和main-content开始标签 -->
<%@ include file="common/navbar.jsp" %>

<!-- 3. 页面特有样式 -->
<style>
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .fade-in-up { animation: fadeInUp 0.8s ease-out; }
    
    .pet-type.dog { background-color: #e3f2fd; color: #2196f3; }
    .pet-type.cat { background-color: #f3e5f5; color: #9c27b0; }
    
    .loading-spinner { display: none; text-align: center; padding: 40px; }
    .spinner {
        border: 5px solid #3192e2ff;
        border-top: 5px solid #1e4172ff;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        animation: spin 1s linear infinite;
        margin: 0 auto 20px;
    }
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>

<!-- 4. 页面主体内容 -->
<section class="hero fade-in-up">
    <div class="container">
        <h1>给流浪宠物一个温暖的家</h1>
        <p>我们连接爱心人士与需要帮助的宠物，让领养变得简单、可靠。每一只宠物都值得被爱，每一次领养都是拯救一个生命。</p>
        <div style="margin-top: 40px;">
            <a href="${ctx}/pet/list" class="btn btn-primary" style="padding: 12px 35px; font-size: 1.1rem;">
                <i class="fas fa-search"></i> 浏览待领养宠物
            </a>
            <a href="${ctx}/donate" class="btn btn-secondary" style="margin-left: 15px; padding: 12px 35px; font-size: 1.1rem;">
                <i class="fas fa-heart"></i> 爱心捐赠
            </a>
        </div>
    </div>
</section>

<section class="services-section">
    <div class="container">
        <h2 class="section-title">我们的服务</h2>
        <div class="services-grid">
            <div class="service-card fade-in-up" style="animation-delay: 0.1s;">
                <div class="service-icon"><i class="fas fa-home"></i></div>
                <h3>宠物领养</h3>
                <p>为流浪动物寻找永久的家，提供完整的领养流程支持。</p>
                <a href="${ctx}/pet/list" class="view-details" style="margin-top: 15px; display: inline-block;">了解更多</a>
            </div>
            <div class="service-card fade-in-up" style="animation-delay: 0.2s;">
                <div class="service-icon"><i class="fas fa-hands-helping"></i></div>
                <h3>临时寄养</h3>
                <p>为宠物主人提供可靠的临时寄养服务。</p>
                <a href="${ctx}/foster" class="view-details" style="margin-top: 15px; display: inline-block;">了解更多</a>
            </div>
            <div class="service-card fade-in-up" style="animation-delay: 0.3s;">
                <div class="service-icon"><i class="fas fa-donate"></i></div>
                <h3>爱心捐赠</h3>
                <p>支持我们的救助工作，帮助更多小生命。</p>
                <a href="${ctx}/donate" class="view-details" style="margin-top: 15px; display: inline-block;">了解更多</a>
            </div>
        </div>
    </div>
</section>

<section class="pets-section">
    <div class="container">
        <h2 class="section-title">待领养宠物</h2>
        <div class="loading-spinner" id="loadingSpinner">
            <div class="spinner"></div>
            <p>正在加载宠物信息...</p>
        </div>
        <div class="pets-grid" id="petsGrid">
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/dog1.jpg" alt="小白" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">小白</h3>
                    <div class="pet-meta">
                        <span class="pet-type dog">狗狗</span>
                        <span class="pet-gender"><i class="fas fa-mars"></i> 公</span>
                        <span class="pet-age"><i class="fas fa-birthday-cake"></i> 2岁</span>
                    </div>
                    <p class="pet-description">活泼可爱的小比熊，非常亲人，已绝育并完成疫苗接种。</p>
                    <a href="${ctx}/pet/detail?id=1" class="view-details">查看详情 <i class="fas fa-arrow-right"></i></a>
                </div>
            </div>
            <!-- 其他宠物卡片... -->
        </div>
        <div class="view-more">
            <a href="${ctx}/pet/list" class="btn btn-primary"><i class="fas fa-paw"></i> 查看更多宠物</a>
        </div>
    </div>
</section>

<!-- 5. 包含页脚 -->
<%@ include file="common/footer.jsp" %>

<!-- 6. 页面特有脚本 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            document.getElementById('loadingSpinner').style.display = 'none';
            document.getElementById('petsGrid').style.opacity = '1';
        }, 1000);
        
        const fadeElements = document.querySelectorAll('.fade-in-up');
        const fadeInOnScroll = function() {
            fadeElements.forEach(element => {
                const elementTop = element.getBoundingClientRect().top;
                const elementVisible = 150;
                if (elementTop < window.innerHeight - elementVisible) {
                    element.classList.add('active');
                }
            });
        };
        fadeInOnScroll();
        window.addEventListener('scroll', fadeInOnScroll);
    });
</script>