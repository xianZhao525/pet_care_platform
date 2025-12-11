package com.petplatform.service.impl;

import com.petplatform.dao.UserRepository;
import com.petplatform.dao.RoleRepository;
import com.petplatform.entity.User;
import com.petplatform.entity.Role;
import com.petplatform.dto.UserDTO;
import com.petplatform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public User register(User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("用户名已存在");
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("邮箱已被注册");
        }

        // 加密密码
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    @Override
    public Optional<User> login(String username, String password) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (passwordEncoder.matches(password, user.getPassword())) {
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    @Override
    public User updateProfile(Long userId, User updatedUser) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));

        user.setEmail(updatedUser.getEmail());
        user.setPhone(updatedUser.getPhone());
        user.setAddress(updatedUser.getAddress());
        user.setAvatar(updatedUser.getAvatar());

        return userRepository.save(user);
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }

    @Override
    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }

    @Override
    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    // 新增方法：用于AdminController
    @Override
    public long getUserCount() {
        return userRepository.count();
    }

    @Override
    public Page<User> getAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @Override
    public List<User> searchUsers(String keyword) {
        // 修复：使用 collect(Collectors.toList()) 而不是 .toList()
        List<User> allUsers = userRepository.findAll();
        return allUsers.stream()
                .filter(user -> user.getUsername().toLowerCase().contains(keyword.toLowerCase()) ||
                        (user.getEmail() != null && user.getEmail().toLowerCase().contains(keyword.toLowerCase())) ||
                        (user.getPhone() != null && user.getPhone().contains(keyword)))
                .collect(Collectors.toList());
    }

    @Override
    public User registerUser(UserDTO userDTO) {
        // 检查用户名和邮箱是否已存在
        if (userRepository.existsByUsername(userDTO.getUsername())) {
            throw new RuntimeException("用户名已存在");
        }
        if (userRepository.existsByEmail(userDTO.getEmail())) {
            throw new RuntimeException("邮箱已被注册");
        }
        
        // 创建User对象
        User user = new User();
        user.setUsername(userDTO.getUsername());
        user.setPassword(passwordEncoder.encode(userDTO.getPassword())); // 加密密码
        user.setEmail(userDTO.getEmail());
        user.setPhone(userDTO.getPhone());
        user.setAddress(userDTO.getAddress());
        
        // 如果有头像URL，设置头像
        if (userDTO.getAvatarUrl() != null && !userDTO.getAvatarUrl().isEmpty()) {
            user.setAvatar(userDTO.getAvatarUrl());
        }
        
        return userRepository.save(user);
    }

    @Override
    public User updateUser(Long userId, UserDTO userDTO) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        // 更新邮箱（如果提供了新邮箱且与旧邮箱不同）
        if (userDTO.getEmail() != null && !userDTO.getEmail().isEmpty() 
                && !userDTO.getEmail().equals(user.getEmail())) {
            // 检查新邮箱是否已被其他用户使用
            if (userRepository.existsByEmailAndIdNot(userDTO.getEmail(), userId)) {
                throw new RuntimeException("邮箱已被其他用户使用");
            }
            user.setEmail(userDTO.getEmail());
        }
        
        // 更新其他字段
        if (userDTO.getPhone() != null) {
            user.setPhone(userDTO.getPhone());
        }
        if (userDTO.getAddress() != null) {
            user.setAddress(userDTO.getAddress());
        }
        if (userDTO.getAvatarUrl() != null && !userDTO.getAvatarUrl().isEmpty()) {
            user.setAvatar(userDTO.getAvatarUrl());
        }
        
        // 如果需要更新密码
        if (userDTO.getPassword() != null && !userDTO.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        }
        
        return userRepository.save(user);
    }
}