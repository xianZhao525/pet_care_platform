package com.petplatform.service;

import com.petplatform.entity.User;
import com.petplatform.dto.UserDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserService {

    User registerUser(UserDTO userDTO);

    User login(String username, String password);

    User updateUser(Long userId, UserDTO userDTO);

    void deleteUser(Long userId);

    User getUserById(Long userId);

    User getUserByUsername(String username);

    Page<User> getAllUsers(Pageable pageable);

    List<User> searchUsers(String keyword);

    void changePassword(Long userId, String oldPassword, String newPassword);

    void resetPassword(String email);

    void updateUserRole(Long userId, List<String> roleNames);

    long getUserCount();

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);
}