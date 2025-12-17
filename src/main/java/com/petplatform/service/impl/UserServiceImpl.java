package com.petplatform.service.impl;

import com.petplatform.dto.UserDTO;
import com.petplatform.entity.User;
import com.petplatform.dao.UserRepository;
import com.petplatform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails; // ✅ 添加导入
import org.springframework.security.core.userdetails.UsernameNotFoundException; // ✅ 添加导入
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Value;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Value("${app.admin.registration.code}")
    private String adminRegistrationCode;

    @Override
    public User registerUser(UserDTO userDTO) {
        System.out.println("======================================");
        System.out.println("🎯 UserServiceImpl.registerUser() 开始执行");
        System.out.println("用户名: " + userDTO.getUsername());
        System.out.println("手机号: " + userDTO.getPhone());
        System.out.println("角色: " + userDTO.getRole());
        System.out.println("======================================");

        // 检查用户名是否已存在
        if (userRepository.findByUsername(userDTO.getUsername()).isPresent()) {
            throw new RuntimeException("用户名已存在");
        }

        // ✅ 角色验证和转换
        User.UserRole role = User.UserRole.USER; // 默认普通用户
        if ("ADMIN".equals(userDTO.getRole())) {
            if ("ADMIN".equals(userDTO.getRole())) {
                if (userDTO.getAdminCode() == null || !userDTO.getAdminCode().equals(adminRegistrationCode)) {
                    System.out.println("❌ 管理员注册码错误 - 输入: " + userDTO.getAdminCode() + ", 期望: " + adminRegistrationCode);
                    throw new RuntimeException("管理员注册码错误");
                }
                System.out.println("✅ 管理员注册码验证通过");
            }

            // String adminCode = userDTO.getAdminCode();
            // String expectedCode = "ADMIN_2025_SECURE_CODE"; // 硬编码测试，后续可放配置
            // if (adminCode == null || !adminCode.equals(expectedCode)) {
            // throw new RuntimeException("管理员注册码错误");
            // }
            // role = User.UserRole.ADMIN;
            // System.out.println("✅ 管理员注册码验证通过");

            // 验证管理员注册码
            // if (userDTO.getAdminCode() == null ||
            // !userDTO.getAdminCode().equals(adminRegistrationCode)) {
            // System.out.println("❌ 管理员注册码错误: " + userDTO.getAdminCode());
            // throw new RuntimeException("管理员注册码错误，无法注册管理员账户");
            // }
            // role = User.UserRole.ADMIN;
            // System.out.println("✅ 管理员注册码验证通过");
        }

        // 创建新用户
        User user = new User();
        user.setUsername(userDTO.getUsername());
        user.setPhone(userDTO.getPhone());
        user.setEmail(userDTO.getEmail());

        String rawPassword = userDTO.getPassword();
        String encodedPassword = passwordEncoder.encode(rawPassword);
        System.out.println("原始密码: " + rawPassword);
        System.out.println("加密后密码: " + encodedPassword);

        user.setPassword(encodedPassword);
        user.setRole(role);

        User savedUser = userRepository.save(user);
        System.out.println("✅ 用户保存成功 - ID: " + savedUser.getId());

        return savedUser;
    }

    @Override
    public Optional<User> login(String username, String password) {
        return userRepository.findByUsername(username)
                .map(user -> {
                    System.out.println("找到用户: " + user.getUsername());
                    System.out.println("数据库密码: " + user.getPassword());
                    boolean matches = passwordEncoder.matches(password, user.getPassword());
                    System.out.println("密码匹配: " + matches);
                    return matches ? user : null;
                });
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }

    @Override
    public User updateUser(Long userId, UserDTO userDTO) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));

        user.setPhone(userDTO.getPhone());
        user.setEmail(userDTO.getEmail());
        if (userDTO.getPassword() != null && !userDTO.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        }

        return userRepository.save(user);
    }

    @Override
    public Page<User> getAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @Override
    public List<User> searchUsers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return userRepository.findAll();
        }
        return userRepository.findByUsernameContainingOrEmailContaining(keyword, keyword);
    }

    @Override
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }

    @Override
    public long getUserCount() {
        return userRepository.count();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username)
                .map(user -> org.springframework.security.core.userdetails.User
                        .withUsername(user.getUsername())
                        .password(user.getPassword())
                        .roles(user.getRole().name())
                        .build())
                .orElseThrow(() -> new UsernameNotFoundException("用户不存在: " + username));
    }
}