package com.petplatform.service;

import com.petplatform.dto.LoginDTO;
import com.petplatform.dto.UserDTO;
import com.petplatform.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetailsService; // ✅ 添加导入
import java.util.List;
import java.util.Optional;

public interface UserService extends UserDetailsService { // ✅ 继承 UserDetailsService

    // 用户注册
    User registerUser(UserDTO userDTO);

    // 用户登录（验证用户名密码）
    Optional<User> login(String username, String password);

    // 根据用户名查找用户
    Optional<User> findByUsername(String username);

    // 根据ID查找用户
    Optional<User> getUserById(Long userId);

    // 更新用户信息
    User updateUser(Long userId, UserDTO userDTO);

    // 获取所有用户（分页）
    Page<User> getAllUsers(Pageable pageable);

    // 搜索用户
    List<User> searchUsers(String keyword);

    // 删除用户
    void deleteUser(Long userId);

    // 获取用户总数
    long getUserCount();
}