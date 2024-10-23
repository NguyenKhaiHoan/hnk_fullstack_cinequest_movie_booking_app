package com.example.cinequest.util;

import com.example.cinequest.dto.request.LoginRequest;
import com.example.cinequest.dto.request.ResetPasswordRequest;
import com.example.cinequest.dto.request.SignUpRequest;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;

import java.util.regex.Pattern;

public class ValidateUtil {
    private ValidateUtil() {}

    public static void validateEmail(String email) {
        final String EMAIL_REGEX = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        if (!Pattern.matches(EMAIL_REGEX, email)) {
            throw new CineQuestApiException(false, ApiResponseCode.INVALID_EMAIL_FORMAT);
        }
    }

    public static void validateSignUpRequest(SignUpRequest request) {
        validateEmail(request.getEmail());
        validatePassword(request.getPassword());
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new CineQuestApiException(false, ApiResponseCode.PASSWORDS_DO_NOT_MATCH);
        }
    }

    public static void validateLoginRequest(LoginRequest request) {
        validateEmail(request.getEmail());
        validatePassword(request.getPassword());
    }

    public static void validateResetPasswordRequest(ResetPasswordRequest request) {
        validatePassword(request.getNewPassword());
        validatePassword(request.getConfirmPassword());
        validatePasswordConfirm(request.getNewPassword(),
                request.getConfirmPassword());
    }

    public static void validatePassword(String password) {
        if (password.length() < 8) {
            throw new CineQuestApiException(false, ApiResponseCode.PASSWORD_TOO_SHORT);
        }
        if (!password.matches(".*[A-Z].*")) {
            throw new CineQuestApiException(false, ApiResponseCode.PASSWORD_MISSING_UPPERCASE);
        }
        if (!password.matches(".*\\d.*")) {
            throw new CineQuestApiException(false, ApiResponseCode.PASSWORD_MISSING_NUMBER);
        }
        if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            throw new CineQuestApiException(false, ApiResponseCode.PASSWORD_MISSING_SPECIAL);
        }
    }

    public static void validatePasswordConfirm(String password, String confirmPassword) {
        if (!password.equals(confirmPassword)) {
            throw new CineQuestApiException(false, ApiResponseCode.PASSWORDS_DO_NOT_MATCH);
        }
    }
}
