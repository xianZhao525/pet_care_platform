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
    .pet-type.rabbit { background-color: #e8f5e9; color: #4caf50; }
    
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
    
    .breed-feature {
        display: flex;
        align-items: center;
        margin: 8px 0;
        font-size: 0.9rem;
    }
    
    .breed-feature i {
        width: 20px;
        margin-right: 8px;
        color: var(--primary-color);
    }
    
    .breed-info {
        margin-top: 15px;
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
        <h2 class="section-title">宠物品种介绍</h2>
        <p class="section-subtitle" style="text-align: center; color: var(--text-light); margin-bottom: 40px; max-width: 800px; margin-left: auto; margin-right: auto;">
            了解不同宠物品种的特点，选择最适合您家庭的新成员
        </p>
        
        <div class="pets-grid" id="petsGrid">
            <!-- 金毛寻回犬 -->
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/golden_retriever.jpg" alt="金毛寻回犬" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">金毛寻回犬</h3>
                    <div class="pet-meta">
                        <span class="pet-type dog">狗狗</span>
                        <span class="pet-age"><i class="fas fa-ruler-combined"></i> 中大型犬</span>
                    </div>
                    <div class="breed-info">
                        <div class="breed-feature">
                            <i class="fas fa-heart"></i>
                            <span>性格特点：友善温顺，聪明忠诚</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-home"></i>
                            <span>适合家庭：有孩子的家庭</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-running"></i>
                            <span>运动需求：每天1-2小时</span>
                        </div>
                    </div>
                    <p class="pet-description">被称为"暖男"的金毛，是极受欢迎的家庭伴侣犬，对孩子非常友好。</p>
                </div>
            </div>
            
            <!-- 哈士奇 -->
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/husky.jpg" alt="哈士奇" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">哈士奇</h3>
                    <div class="pet-meta">
                        <span class="pet-type dog">狗狗</span>
                        <span class="pet-age"><i class="fas fa-ruler-combined"></i> 中大型犬</span>
                    </div>
                    <div class="breed-info">
                        <div class="breed-feature">
                            <i class="fas fa-heart"></i>
                            <span>性格特点：活泼好动，独立有个性</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-home"></i>
                            <span>适合家庭：有院子的家庭</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-running"></i>
                            <span>运动需求：每天2小时以上</span>
                        </div>
                    </div>
                    <p class="pet-description">精力充沛的"二哈"，需要大量运动和训练，不适合新手饲养。</p>
                </div>
            </div>
            
            <!-- 萨摩耶 -->
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/samoyed.jpg" alt="萨摩耶" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">萨摩耶</h3>
                    <div class="pet-meta">
                        <span class="pet-type dog">狗狗</span>
                        <span class="pet-age"><i class="fas fa-ruler-combined"></i> 中大型犬</span>
                    </div>
                    <div class="breed-info">
                        <div class="breed-feature">
                            <i class="fas fa-heart"></i>
                            <span>性格特点：温和友善，微笑天使</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-home"></i>
                            <span>适合家庭：有时间的家庭</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-snowflake"></i>
                            <span>特殊需求：需要定期美容</span>
                        </div>
                    </div>
                    <p class="pet-description">拥有招牌"萨摩耶微笑"的美丽犬种，性格温和但需要精心打理毛发。</p>
                </div>
            </div>
            
            <!-- 垂耳兔 -->
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/lop_rabbit.jpg" alt="垂耳兔" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">垂耳兔</h3>
                    <div class="pet-meta">
                        <span class="pet-type rabbit">兔子</span>
                        <span class="pet-age"><i class="fas fa-ruler-combined"></i> 小型宠物</span>
                    </div>
                    <div class="breed-info">
                        <div class="breed-feature">
                            <i class="fas fa-heart"></i>
                            <span>性格特点：温顺安静，胆小敏感</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-home"></i>
                            <span>饲养环境：室内笼养</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-carrot"></i>
                            <span>饮食需求：干草+蔬菜+兔粮</span>
                        </div>
                    </div>
                    <p class="pet-description">可爱的垂耳兔是理想的室内宠物，需要精心照料和定期的健康检查。</p>
                </div>
            </div>
            
            <!-- 布偶猫 -->
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/ragdoll_cat.jpg" alt="布偶猫" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">布偶猫</h3>
                    <div class="pet-meta">
                        <span class="pet-type cat">猫咪</span>
                        <span class="pet-age"><i class="fas fa-ruler-combined"></i> 中大型猫</span>
                    </div>
                    <div class="breed-info">
                        <div class="breed-feature">
                            <i class="fas fa-heart"></i>
                            <span>性格特点：温顺粘人，像布偶一样</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-home"></i>
                            <span>适合家庭：所有家庭</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-snowflake"></i>
                            <span>特殊需求：需要梳理长毛</span>
                        </div>
                    </div>
                    <p class="pet-description">被称为"小狗猫"的布偶，性格极其温顺，喜欢跟随主人。</p>
                </div>
            </div>
            
            <!-- 橘猫 -->
            <div class="pet-card fade-in-up">
                <div class="pet-image-container">
                    <img src="${ctx}/images/pets/orange_cat.jpg" alt="橘猫" class="pet-image" onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                </div>
                <div class="pet-info">
                    <h3 class="pet-name">橘猫</h3>
                    <div class="pet-meta">
                        <span class="pet-type cat">猫咪</span>
                        <span class="pet-age"><i class="fas fa-ruler-combined"></i> 中型猫</span>
                    </div>
                    <div class="breed-info">
                        <div class="breed-feature">
                            <i class="fas fa-heart"></i>
                            <span>性格特点：活泼亲人，贪吃爱睡</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-home"></i>
                            <span>适合环境：适应力强</span>
                        </div>
                        <div class="breed-feature">
                            <i class="fas fa-utensils"></i>
                            <span>饮食注意：控制食量防肥胖</span>
                        </div>
                    </div>
                    <p class="pet-description">十只橘猫九只胖，还有一只特别胖。性格通常很友好，容易相处。</p>
                </div>
            </div>
        </div>
        
        <div class="view-more">
            <a href="${ctx}/pet/list" class="btn btn-primary"><i class="fas fa-paw"></i> 查看待领养宠物</a>
        </div>
    </div>
</section>

<!-- 5. 包含页脚 -->
<%@ include file="common/footer.jsp" %>

<!-- 6. 页面特有脚本 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 原有的加载动画逻辑
        setTimeout(function() {
            document.getElementById('loadingSpinner').style.display = 'none';
            document.getElementById('petsGrid').style.opacity = '1';
        }, 1000);
        
        // 滚动淡入效果
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
        
        // 初始检查和滚动监听
        fadeInOnScroll();
        window.addEventListener('scroll', fadeInOnScroll);
        
        // 为宠物卡片添加悬停效果
        const petCards = document.querySelectorAll('.pet-card');
        petCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px)';
                this.style.boxShadow = '0 15px 30px rgba(0, 0, 0, 0.15)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.08)';
            });
        });
    });
</script>