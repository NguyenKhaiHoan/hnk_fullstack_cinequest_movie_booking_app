package com.example.cinequest.service;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.entity.User;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.repository.UserRepository;
import com.example.cinequest.util.ValidateUtil;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ResetPasswordService {
    UserRepository userRepository;

    public void resetPassword(String resetPasswordFormId, String newPassword) {
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

        User user = isExpiredFormResetPassword(resetPasswordFormId);

        user.setPassword(passwordEncoder.encode(newPassword));

        user.setResetPasswordFormId(null);
        user.setResetPasswordFormExpiresAt(null);
        userRepository.save(user);
    }

    public User isExpiredFormResetPassword(String resetPasswordFormId) {
        User user = userRepository.findByResetPasswordFormId(resetPasswordFormId).orElseThrow(
                () -> new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND)
        );

        if (user.getResetPasswordFormExpiresAt().isBefore(LocalDateTime.now())) {
            throw new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND);
        }

        return user;
    }
}
