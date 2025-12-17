<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>领养宠物 - 宠物领养平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Hero区域样式 - 与捐赠页面保持一致 */
        .pet-hero {
            background: linear-gradient(135deg, #ec965dff 0%, #fd4b4bff 100%);
            color: white;
            padding: 100px 0;
            text-align: center;
            margin-bottom: 50px;
        }
        
        /* 统计信息卡片 - 与捐赠页面保持一致 */
        .pet-stats {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin: -50px auto 50px;
            max-width: 900px;
            position: relative;
            z-index: 10;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
            border-right: 1px solid #eee;
        }
        
        .stat-item:last-child {
            border-right: none;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--primary-color);
            display: block;
        }
        
        /* 宠物卡片样式 - 与首页保持一致 */
        .pets-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .pet-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            opacity: 0;
            animation: fadeInUp 0.6s ease-out forwards;
        }
        
        .pet-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .pet-image-container {
            width: 100%;
            height: 250px;
            overflow: hidden;
            position: relative;
        }
        
        .pet-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .pet-card:hover .pet-image {
            transform: scale(1.1);
        }
        
        /* 宠物类型标签 - 带颜色区分 */
        .pet-type-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            color: white;
            z-index: 2;
        }
        
        .pet-type-badge.dog { background: linear-gradient(135deg, #4e97fd 0%, #6a11cb 100%); }
        .pet-type-badge.cat { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .pet-type-badge.rabbit { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }
        .pet-type-badge.bird { background: linear-gradient(135deg, #30cfd0 0%, #330867 100%); }
        .pet-type-badge.other { background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%); }
        
        .pet-info {
            padding: 25px;
        }
        
        .pet-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--dark-color);
        }
        
        .pet-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }
        
        .pet-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #666;
            font-size: 0.9rem;
        }
        
        .pet-description {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .pet-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .status-available { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-adopted { background: #f8d7da; color: #721c24; }
        
        /* 搜索筛选区域 */
        .search-filter-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }
        
        .search-box {
            position: relative;
            max-width: 500px;
            margin: 0 auto;
        }
        
        .search-box input {
            width: 100%;
            padding: 15px 50px 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 30px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(78, 151, 253, 0.1);
        }
        
        .search-box button {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            cursor: pointer;
        }
        
        .filter-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 8px 20px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .filter-btn:hover,
        .filter-btn.active {
            border-color: var(--primary-color);
            background: var(--primary-color);
            color: white;
        }
        
        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        /* 加载动画 */
        .loading-spinner {
            text-align: center;
            padding: 40px;
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <jsp:include page="../common/navbar.jsp" />
    
    <!-- Hero区域 -->
    <div class="pet-hero">
        <div class="container">
            <h1 class="display-4 fade-in-up">
                <i class="fas fa-paw"></i> 领养宠物
            </h1>
            <p class="lead">给流浪的毛孩子一个温暖的家，每一次领养都是拯救一个生命</p>
        </div>
    </div>
    
    <!-- 统计信息 -->
    <div class="container">
        <div class="pet-stats">
            <div class="row">
                <div class="col-md-4 stat-item">
                    <span class="stat-number">${stats.availableCount}</span>
                    <div>待领养宠物</div>
                </div>
                <div class="col-md-4 stat-item">
                    <span class="stat-number">${stats.adoptedCount}</span>
                    <div>已被领养</div>
                </div>
                <div class="col-md-4 stat-item">
                    <span class="stat-number">${stats.fosteredCount}</span>
                    <div>寄养中</div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 搜索筛选区域 -->
    <div class="container">
        <div class="search-filter-section">
            <form action="${ctx}/pet/list" method="get">
                <div class="search-box">
                    <input type="text" name="keyword" value="${param.keyword}" 
                           placeholder="搜索宠物名称、品种或描述...">
                    <button type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div class="filter-buttons">
                    <button type="button" class="filter-btn active" data-type="all">全部</button>
                    <button type="button" class="filter-btn" data-type="DOG">狗狗</button>
                    <button type="button" class="filter-btn" data-type="CAT">猫咪</button>
                    <button type="button" class="filter-btn" data-type="RABBIT">兔子</button>
                    <button type="button" class="filter-btn" data-type="OTHER">其他</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 宠物列表 -->
    <div class="container mb-5">
        <h2 class="section-title text-center fade-in-up">待领养毛孩子</h2>
        
        <c:choose>
            <c:when test="${empty pets}">
                <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <h3>暂无符合条件的宠物</h3>
                    <p>试试其他搜索条件或稍后再来看看吧</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="pets-grid">
                    <c:forEach items="${pets}" var="pet" varStatus="status">
                        <div class="pet-card" style="animation-delay: ${status.index * 0.1}s;">
                            <div class="pet-image-container">
                                <img src="${ctx}/images/pets/${pet.imageUrl}" 
                                     alt="${pet.name}" 
                                     class="pet-image"
                                     onerror="this.onerror=null;this.src='${ctx}/images/pets/default.jpg'">
                                <span class="pet-type-badge ${pet.type.name().toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${pet.type == 'DOG'}">狗狗</c:when>
                                        <c:when test="${pet.type == 'CAT'}">猫咪</c:when>
                                        <c:when test="${pet.type == 'RABBIT'}">兔子</c:when>
                                        <c:when test="${pet.type == 'BIRD'}">鸟类</c:when>
                                        <c:otherwise>其他</c:otherwise>
                                    </c:choose>
                                </span>
                                <c:if test="${pet.status != 'AVAILABLE'}">
                                    <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; 
                                                background: rgba(0,0,0,0.6); display: flex; 
                                                align-items: center; justify-content: center;">
                                        <span style="color: white; font-size: 1.2rem; font-weight: bold;">
                                            <c:if test="${pet.status == 'ADOPTED'}">已领养</c:if>
                                            <c:if test="${pet.status == 'FOSTERED'}">寄养中</c:if>
                                        </span>
                                    </div>
                                </c:if>
                            </div>
                            <div class="pet-info">
                                <h3 class="pet-name">${pet.name}</h3>
                                <div class="pet-meta">
                                    <div class="pet-meta-item">
                                        <i class="fas fa-tag"></i>
                                        <span>${pet.breed}</span>
                                    </div>
                                    <div class="pet-meta-item">
                                        <i class="fas fa-${pet.gender == '公' ? 'mars' : 'venus'}"></i>
                                        <span>${pet.gender}</span>
                                    </div>
                                    <div class="pet-meta-item">
                                        <i class="fas fa-birthday-cake"></i>
                                        <span>${pet.age}岁</span>
                                    </div>
                                </div>
                                <p class="pet-description">${pet.description}</p>
                                <div class="pet-meta">
                                    <div class="pet-meta-item">
                                        <i class="fas fa-heartbeat"></i>
                                        <span>${pet.healthStatus}</span>
                                    </div>
                                    <div class="pet-meta-item">
                                        <i class="fas fa-syringe"></i>
                                        <span>${pet.vaccination}</span>
                                    </div>
                                </div>
                                <a href="${ctx}/pet/detail?id=${pet.id}" class="btn btn-primary w-100">
                                    <i class="fas fa-info-circle"></i> 查看详情
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 筛选按钮交互
            const filterButtons = document.querySelectorAll('.filter-btn');
            filterButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    filterButtons.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    // 这里可以添加筛选逻辑
                    console.log('筛选类型:', this.dataset.type);
                });
            });
            
            // 卡片渐入动画
            const cards = document.querySelectorAll('.pet-card');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                    }
                });
            });
            
            cards.forEach(card => observer.observe(card));
        });
    </script>
</body>
</html>