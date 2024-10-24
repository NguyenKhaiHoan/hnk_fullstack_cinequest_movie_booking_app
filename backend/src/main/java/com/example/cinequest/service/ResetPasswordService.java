package com.example.cinequest.service;

import com.example.cinequest.entity.User;

public interface ResetPasswordService {
    void resetPassword(String resetPasswordFormId, String newPassword);

    User isExpiredFormResetPassword(String resetPasswordFormId);
}
