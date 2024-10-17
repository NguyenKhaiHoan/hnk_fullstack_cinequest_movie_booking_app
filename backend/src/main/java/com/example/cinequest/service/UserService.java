package com.example.cinequest.service;

import java.util.List;

import com.example.cinequest.dto.repsonse.UserResponse;
import com.example.cinequest.entity.User;

public interface UserService {
    UserResponse getUser(String email);

    List<User> getUsers();
}
