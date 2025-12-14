<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宠物领养平台 - 给流浪宠物一个温暖的家</title>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <style>
        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
        }
        
        /* 添加一些额外动画效果 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .fade-in-up {
            animation: fadeInUp 0.8s ease-out;
        }
        
        /* 宠物类型标签颜色 */
        .pet-type.dog {
            background-color: #e3f2fd;
            color: #2196f3;
        }
        
        .pet-type.cat {
            background-color: #f3e5f5;
            color: #9c27b0;
        }
        
        /* 加载动画 */
        .loading-spinner {
            display: none;
            text-align: center;
            padding: 40px;
        }
        
        .spinner {
            border: 5px solid #f3f3f3;
            border-top: 5px solid #4e97fd;
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
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar">
        <div class="container navbar-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <i class="fas fa-paw"></i> 宠物领养平台
            </a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="active">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/pets">领养宠物</a></li>
                <li><a href="${pageContext.request.contextPath}/foster">临时寄养</a></li>
                <li><a href="${pageContext.request.contextPath}/donate">爱心捐赠</a></li>
                <li><a href="${pageContext.request.contextPath}/about">关于我们</a></li>
            </ul>
            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">登录</a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">注册</a>
            </div>
        </div>
    </nav>

    <!-- 英雄区域 -->
    <section class="hero fade-in-up">
        <div class="container">
            <h1>给流浪宠物一个温暖的家</h1>
            <p>我们连接爱心人士与需要帮助的宠物，让领养变得简单、可靠。每一只宠物都值得被爱，每一次领养都是拯救一个生命。</p>
            <div style="margin-top: 40px;">
                <a href="${pageContext.request.contextPath}/pets" class="btn btn-primary" style="padding: 12px 35px; font-size: 1.1rem;">
                    <i class="fas fa-search"></i> 浏览待领养宠物
                </a>
                <a href="${pageContext.request.contextPath}/donate" class="btn btn-secondary" style="margin-left: 15px; padding: 12px 35px; font-size: 1.1rem;">
                    <i class="fas fa-heart"></i> 爱心捐赠
                </a>
            </div>
        </div>
    </section>

    <!-- 我们的服务 -->
    <section class="services-section">
        <div class="container">
            <h2 class="section-title">我们的服务</h2>
            <div class="services-grid">
                <div class="service-card fade-in-up" style="animation-delay: 0.1s;">
                    <div class="service-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <h3>宠物领养</h3>
                    <p>为流浪动物寻找永久的家，提供完整的领养流程支持，包括健康检查、疫苗接种和领养后回访。</p>
                    <a href="${pageContext.request.contextPath}/pets" class="view-details" style="margin-top: 15px; display: inline-block;">了解更多</a>
                </div>
                
                <div class="service-card fade-in-up" style="animation-delay: 0.2s;">
                    <div class="service-icon">
                        <i class="fas fa-hands-helping"></i>
                    </div>
                    <h3>临时寄养</h3>
                    <p>为宠物主人提供可靠的临时寄养服务，我们的寄养家庭都经过严格审核，确保宠物得到最好的照顾。</p>
                    <a href="${pageContext.request.contextPath}/foster" class="view-details" style="margin-top: 15px; display: inline-block;">了解更多</a>
                </div>
                
                <div class="service-card fade-in-up" style="animation-delay: 0.3s;">
                    <div class="service-icon">
                        <i class="fas fa-donate"></i>
                    </div>
                    <h3>爱心捐赠</h3>
                    <p>支持我们的救助工作，帮助更多小生命。您的每一份捐赠都将用于宠物的医疗、食物和救助设施。</p>
                    <a href="${pageContext.request.contextPath}/donate" class="view-details" style="margin-top: 15px; display: inline-block;">了解更多</a>
                </div>
            </div>
        </div>
    </section>

    <!-- 待领养宠物 -->
    <section class="pets-section">
        <div class="container">
            <h2 class="section-title">待领养宠物</h2>
            
            <!-- 加载动画 -->
            <div class="loading-spinner" id="loadingSpinner">
                <div class="spinner"></div>
                <p>正在加载宠物信息...</p>
            </div>
            
            <!-- 宠物列表 -->
            <div class="pets-grid" id="petsGrid">
                <!-- 宠物卡片将通过JavaScript动态加载 -->
                <!-- 这里显示静态示例数据，实际项目中应从后端获取 -->
                <div class="pet-card fade-in-up">
                    <div class="pet-image-container">
                        <img src="${pageContext.request.contextPath}/images/pets/dog1.jpg" alt="小白" class="pet-image" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/pets/default.jpg'">
                    </div>
                    <div class="pet-info">
                        <h3 class="pet-name">小白</h3>
                        <div class="pet-meta">
                            <span class="pet-type dog">狗狗</span>
                            <span class="pet-gender"><i class="fas fa-mars"></i> 公</span>
                            <span class="pet-age"><i class="fas fa-birthday-cake"></i> 2岁</span>
                        </div>
                        <p class="pet-description">活泼可爱的小比熊，非常亲人，已绝育并完成疫苗接种，正在寻找一个有爱的家庭。</p>
                        <a href="${pageContext.request.contextPath}/pet-details.jsp?id=1" class="view-details">查看详情 <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
                
                <div class="pet-card fade-in-up">
                    <div class="pet-image-container">
                        <img src="${pageContext.request.contextPath}/images/pets/cat1.jpg" alt="小花" class="pet-image" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/pets/default.jpg'">
                    </div>
                    <div class="pet-info">
                        <h3 class="pet-name">小花</h3>
                        <div class="pet-meta">
                            <span class="pet-type cat">猫咪</span>
                            <span class="pet-gender"><i class="fas fa-venus"></i> 母</span>
                            <span class="pet-age"><i class="fas fa-birthday-cake"></i> 1岁</span>
                        </div>
                        <p class="pet-description">温顺的狸花猫，喜欢被抚摸，已绝育并完成疫苗接种，适合有孩子的家庭。</p>
                        <a href="${pageContext.request.contextPath}/pet-details.jsp?id=2" class="view-details">查看详情 <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
                
                <div class="pet-card fade-in-up">
                    <div class="pet-image-container">
                        <img src="${pageContext.request.contextPath}/images/pets/dog2.jpg" alt="小黑" class="pet-image" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/pets/default.jpg'">
                    </div>
                    <div class="pet-info">
                        <h3 class="pet-name">小黑</h3>
                        <div class="pet-meta">
                            <span class="pet-type dog">狗狗</span>
                            <span class="pet-gender"><i class="fas fa-mars"></i> 公</span>
                            <span class="pet-age"><i class="fas fa-birthday-cake"></i> 3岁</span>
                        </div>
                        <p class="pet-description">聪明的拉布拉多串串，性格温顺，经过基本训练，适合作为家庭伴侣犬。</p>
                        <a href="${pageContext.request.contextPath}/pet-details.jsp?id=3" class="view-details">查看详情 <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
                
                <div class="pet-card fade-in-up">
                    <div class="pet-image-container">
                        <img src="${pageContext.request.contextPath}/images/pets/cat2.jpg" alt="咪咪" class="pet-image" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/pets/default.jpg'">
                    </div>
                    <div class="pet-info">
                        <h3 class="pet-name">咪咪</h3>
                        <div class="pet-meta">
                            <span class="pet-type cat">猫咪</span>
                            <span class="pet-gender"><i class="fas fa-venus"></i> 母</span>
                            <span class="pet-age"><i class="fas fa-birthday-cake"></i> 6个月</span>
                        </div>
                        <p class="pet-description">活泼好动的小奶猫，好奇心强，已驱虫，正在等待一个充满爱的家。</p>
                        <a href="${pageContext.request.contextPath}/pet-details.jsp?id=4" class="view-details">查看详情 <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="view-more">
                <a href="${pageContext.request.contextPath}/pets" class="btn btn-primary">
                    <i class="fas fa-paw"></i> 查看更多宠物
                </a>
            </div>
        </div>
    </section>

    <!-- 页脚 -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-about">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="footer-logo">
                        <i class="fas fa-paw"></i> 宠物领养平台
                    </a>
                    <p class="footer-description">
                        我们致力于为流浪宠物寻找温暖的家，通过领养代替购买，减少流浪动物的数量。
                        每一只宠物都值得被爱，每一个生命都值得尊重。
                    </p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-weixin"></i></a>
                        <a href="#"><i class="fab fa-weibo"></i></a>
                        <a href="#"><i class="fab fa-qq"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                
                <div class="footer-links">
                    <h4>快速链接</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
                        <li><a href="${pageContext.request.contextPath}/pets">领养宠物</a></li>
                        <li><a href="${pageContext.request.contextPath}/foster">临时寄养</a></li>
                        <li><a href="${pageContext.request.contextPath}/donate">爱心捐赠</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">关于我们</a></li>
                    </ul>
                </div>
                
                <div class="footer-contact">
                    <h4>联系我们</h4>
                    <p><i class="fas fa-map-marker-alt"></i> 北京市朝阳区宠物救助中心</p>
                    <p><i class="fas fa-phone"></i> 400-123-4567</p>
                    <p><i class="fas fa-envelope"></i> contact@petadoption.com</p>
                    <p><i class="fas fa-clock"></i> 周一至周五 9:00-18:00</p>
                </div>
            </div>
            
            <div class="copyright">
                <p>&copy; 2025 宠物领养平台. 版权所有. | 设计制作: 爱心技术团队</p>
                <p style="margin-top: 10px; font-size: 0.8rem;">京ICP备12345678号 | 京公网安备11010502012345号</p>
            </div>
        </div>
    </footer>

    <script>
        // 页面加载后执行
        document.addEventListener('DOMContentLoaded', function() {
            // 模拟异步加载宠物数据
            setTimeout(function() {
                // 在实际项目中，这里应该从后端API获取数据
                console.log('宠物数据加载完成');
                
                // 隐藏加载动画
                document.getElementById('loadingSpinner').style.display = 'none';
                
                // 显示宠物网格
                document.getElementById('petsGrid').style.opacity = '1';
                
            }, 1000);
            
            // 添加滚动动画效果
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
            
            // 初始检查
            fadeInOnScroll();
            
            // 滚动时检查
            window.addEventListener('scroll', fadeInOnScroll);
            
            // 导航栏滚动效果
            window.addEventListener('scroll', function() {
                const navbar = document.querySelector('.navbar');
                if (window.scrollY > 50) {
                    navbar.style.boxShadow = '0 5px 20px rgba(0, 0, 0, 0.1)';
                } else {
                    navbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
                }
            });
        });
    </script>
</body>
</html>