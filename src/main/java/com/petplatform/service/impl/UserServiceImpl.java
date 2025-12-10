package main.java.com.petplatform.service.impl;

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
    public User registerUser(UserDTO userDTO) {
        if (existsByUsername(userDTO.getUsername())) {
            throw new RuntimeException("用户名已存在");
        }

        if (existsByEmail(userDTO.getEmail())) {
            throw new RuntimeException("邮箱已被注册");
        }

        User user = new User();
        user.setUsername(userDTO.getUsername());
        user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        user.setEmail(userDTO.getEmail());
        user.setPhone(userDTO.getPhone());
        user.setRealName(userDTO.getRealName());
        user.setAddress(userDTO.getAddress());

        // 默认分配USER角色
        Role userRole = roleRepository.findByName("USER")
                .orElseThrow(() -> new RuntimeException("角色不存在"));
        Set<Role> roles = new HashSet<>();
        roles.add(userRole);
        user.setRoles(roles);

        return userRepository.save(user);
    }

    @Override
    public User login(String username, String password) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        if (!userOptional.isPresent()) {
            throw new RuntimeException("用户不存在");
        }

        User user = userOptional.get();
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("密码错误");
        }

        if (!user.getEnabled()) {
            throw new RuntimeException("账户已被禁用");
        }

        // 更新最后登录时间
        user.setLastLoginTime(new java.util.Date());
        userRepository.save(user);

        return user;
    }

    @Override
    public User updateUser(Long userId, UserDTO userDTO) {
        User user = getUserById(userId);

        if (userDTO.getEmail() != null && !userDTO.getEmail().equals(user.getEmail())) {
            if (existsByEmail(userDTO.getEmail())) {
                throw new RuntimeException("邮箱已被使用");
            }
            user.setEmail(userDTO.getEmail());
        }

        if (userDTO.getPhone() != null) {
            user.setPhone(userDTO.getPhone());
        }

        if (userDTO.getRealName() != null) {
            user.setRealName(userDTO.getRealName());
        }

        if (userDTO.getAddress() != null) {
            user.setAddress(userDTO.getAddress());
        }

        if (userDTO.getAvatarUrl() != null) {
            user.setAvatarUrl(userDTO.getAvatarUrl());
        }

        return userRepository.save(user);
    }

    @Override
    public void deleteUser(Long userId) {
        User user = getUserById(userId);
        user.setEnabled(false);
        userRepository.save(user);
    }

    @Override
    public User getUserById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
    }

    @Override
    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
    }

    @Override
    public Page<User> getAllUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @Override
    public List<User> searchUsers(String keyword) {
        return userRepository.searchUsers(keyword);
    }

    @Override
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = getUserById(userId);

        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new RuntimeException("原密码错误");
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }

    @Override
    public void resetPassword(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("邮箱未注册"));

        // 生成随机密码
        String randomPassword = generateRandomPassword();
        user.setPassword(passwordEncoder.encode(randomPassword));
        userRepository.save(user);

        // 发送邮件（这里可以集成邮件服务）
        // emailService.sendPasswordResetEmail(email, randomPassword);
    }

    @Override
    public void updateUserRole(Long userId, List<String> roleNames) {
        User user = getUserById(userId);
        Set<Role> roles = new HashSet<>();

        for (String roleName : roleNames) {
            Role role = roleRepository.findByName(roleName)
                    .orElseThrow(() -> new RuntimeException("角色不存在: " + roleName));
            roles.add(role);
        }

        user.setRoles(roles);
        userRepository.save(user);
    }

    @Override
    public long getUserCount() {
        return userRepository.count();
    }

    @Override
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    private String generateRandomPassword() {
        // 生成8位随机密码
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = (int) (Math.random() * chars.length());
            password.append(chars.charAt(index));
        }
        return password.toString();
    }
}