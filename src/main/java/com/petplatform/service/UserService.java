// UserService.java
package com.petplatform.service;

import com.petplatform.dto.UserDTO;
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

    long getUserCount();

    Page<User> getAllUsers(Pageable pageable);

    List<User> searchUsers(String keyword);
    
    // 添加Controller需要的方法
    User registerUser(UserDTO userDTO);  // 从UserDTO注册
    
    User updateUser(Long userId, UserDTO userDTO);  // 使用UserDTO更新用户
}