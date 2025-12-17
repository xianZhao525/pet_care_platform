<%-- footer.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </div> <!-- 关闭main-content -->
    
    <!-- 页脚 -->
    <footer class="footer mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-paw"></i> 宠物领养平台</h5>
                    <p class="text-muted">我们致力于为流浪宠物寻找温暖的家，通过领养代替购买，减少流浪动物的数量。</p>
                </div>
                <div class="col-md-4">
                    <h5>快速链接</h5>
                    <ul class="list-unstyled">
                        <li><a href="${ctx}/" class="text-muted">首页</a></li>
                        <li><a href="${ctx}/pet/list" class="text-muted">领养宠物</a></li>
                        <li><a href="${ctx}/about" class="text-muted">关于我们</a></li>
                        <li><a href="${ctx}/contact" class="text-muted">联系我们</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>联系我们</h5>
                    <p class="text-muted">
                        <i class="fas fa-phone me-2"></i> 每一个毛孩子都想要一个可以遮风挡雨的家<br>
                        <i class="fas fa-envelope me-2"></i> contact@petadoption.com<br>
                        <i class="fas fa-map-marker-alt me-2"></i> 用领养代替购买，用爱心代替抛弃
                    </p>
                </div>
            </div>
            <hr>
            <div class="text-center text-muted">
                <p>&copy; 2025 宠物领养平台. 版权所有.</p>
            </div>
        </div>
    </footer>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- 自定义JS -->
    <script src="${ctx}/js/main.js"></script>
    
    <script>
        // 页面加载完成后执行
        document.addEventListener('DOMContentLoaded', function() {
            // 导航栏滚动效果
            window.addEventListener('scroll', function() {
                const navbar = document.querySelector('.navbar');
                if (window.scrollY > 50) {
                    navbar.style.boxShadow = '0 5px 20px rgba(0, 0, 0, 0.15)';
                } else {
                    navbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
                }
            });
            
            // 控制台提示
            console.log('宠物领养平台加载完成');
        });
    </script>
</body>
</html>