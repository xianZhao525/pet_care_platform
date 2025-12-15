<%-- pet-list.jsp --%>
<%@ include file="header.jsp" %>

<div class="container mt-4">
    <h1 class="text-center mb-4">待领养宠物</h1>
    
    <!-- 筛选器 -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">筛选条件</h5>
            <form class="row g-3">
                <div class="col-md-3">
                    <label for="petType" class="form-label">宠物类型</label>
                    <select class="form-select" id="petType">
                        <option value="">全部</option>
                        <option value="dog">狗狗</option>
                        <option value="cat">猫咪</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="gender" class="form-label">性别</label>
                    <select class="form-select" id="gender">
                        <option value="">全部</option>
                        <option value="male">公</option>
                        <option value="female">母</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="age" class="form-label">年龄</label>
                    <select class="form-select" id="age">
                        <option value="">全部</option>
                        <option value="0-1">0-1岁</option>
                        <option value="1-3">1-3岁</option>
                        <option value="3+">3岁以上</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">筛选</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 宠物列表 -->
    <div class="row" id="petsContainer">
        <!-- 宠物卡片将通过JavaScript动态加载 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <img src="${ctx}/images/pets/dog1.jpg" class="card-img-top" alt="小白" style="height: 200px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title">小白</h5>
                    <p class="card-text">
                        <span class="badge bg-primary">狗狗</span>
                        <span class="badge bg-secondary">公</span>
                        <span class="badge bg-info">2岁</span>
                    </p>
                    <p class="card-text">活泼可爱的小比熊，非常亲人，已绝育并完成疫苗接种。</p>
                    <a href="${ctx}/pet/detail/1" class="btn btn-primary">查看详情</a>
                </div>
            </div>
        </div>
        
        <!-- 更多宠物卡片... -->
    </div>
    
    <!-- 分页 -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">上一页</a>
            </li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#">下一页</a>
            </li>
        </ul>
    </nav>
</div>

<%@ include file="footer.jsp" %>