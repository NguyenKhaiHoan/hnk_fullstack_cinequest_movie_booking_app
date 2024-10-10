package com.example.cinequest.service;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.model.request.ForgotPasswordRequest;
import com.example.cinequest.model.request.LoginRequest;
import com.example.cinequest.model.request.SignUpRequest;
import com.example.cinequest.model.request.VerifyUserRequest;
import jakarta.servlet.http.HttpServletRequest;

public interface AuthenticationService {
    AppUser signup(SignUpRequest request);

    AppUser login(LoginRequest request);

    void verify(VerifyUserRequest request);

    void resendVerificationEmail(String email);

    AppUser refreshToken(HttpServletRequest request);

    void saveToken(String refreshToken, String email);

    void forgotPassword(ForgotPasswordRequest request);
}