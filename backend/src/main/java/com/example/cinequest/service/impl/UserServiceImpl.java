package com.example.cinequest.service.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.UserResponse;
import com.example.cinequest.dto.request.ResetPasswordRequest;
import com.example.cinequest.entity.User;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.mapper.UserMapper;
import com.example.cinequest.repository.UserRepository;
import com.example.cinequest.service.UserService;
import com.example.cinequest.util.ValidateUtil;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserServiceImpl implements UserService {
    UserRepository userRepository;

    UserMapper userMapper;

    @Override
    public UserResponse getUser(String email) {
        return userMapper.toUserResponse(userRepository
                .findByEmail(email)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND)));
    }

    @Override
    public List<User> getUsers() {
        return new ArrayList<>(userRepository.findAll());
    }

    @Override
    public Response resetPassword(ResetPasswordRequest request, String resetPasswordFormId) {
        ValidateUtil.validateResetPasswordRequest(request);

        User user;
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

        if (resetPasswordFormId == null && request.getCurrentPassword() != null) {
            var context = SecurityContextHolder.getContext();
            String email = context.getAuthentication().getName();

            user = userRepository
                    .findByEmail(email)
                    .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

            boolean authenticated = passwordEncoder.matches(request.getCurrentPassword(), user.getPassword());

            if (!authenticated) {
                throw new CineQuestApiException(false, ApiResponseCode.BAD_CREDENTIALS);
            }
        } else if (resetPasswordFormId != null && request.getCurrentPassword() == null) {
            user = userRepository
                    .findByResetPasswordFormId(resetPasswordFormId)
                    .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND));

            if (user.getResetPasswordFormExpiresAt().isBefore(LocalDateTime.now())) {
                throw new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND);
            }

            user.setResetPasswordFormId(null);
            user.setResetPasswordFormId(null);
        } else {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);

        return new Response(
                true,
                ApiResponseCode.RESET_PASSWORD_SUCCESS.getStatusCode(),
                ApiResponseCode.RESET_PASSWORD_SUCCESS.getStatusMessage());
    }
}
