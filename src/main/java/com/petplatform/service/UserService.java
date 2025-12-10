package com.petplatform.service;

import com.petplatform.entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface UserService {

    User register(User user);

    Optional<User> login(String username, String password);

    User updateProfile(Long userId, User updatedUser);

    List<User> getAllUsers();

    void deleteUser(Long userId);

    Optional<User> getUserById(Long userId);

    Optional<User> getUserByUsername(String username);

    long getUserCount(); // 用于dashboard页面

    Page<User> getAllUsers(Pageable pageable); // 分页查询，用于manageUsers页面

    List<User> searchUsers(String keyword); // 搜索用户，用于manageUsers页面
}