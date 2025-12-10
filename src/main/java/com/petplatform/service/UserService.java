package com.petplatform.service;

import com.petplatform.entity.User;
import java.util.List;
import java.util.Optional;

public interface UserService {

    User register(User user);

    Optional<User> login(String username, String password);

    User updateProfile(Long userId, User updatedUser);

    List<User> getAllUsers();

    void deleteUser(Long userId);

    Optional<User> getUserById(Long userId);

    Optional<User> getUserByUsername(String username);
}