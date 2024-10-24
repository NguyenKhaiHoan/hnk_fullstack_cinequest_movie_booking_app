package com.example.cinequest.service;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.TokenResponse;
import com.example.cinequest.dto.request.*;

public interface AuthenticationService {
    Response signUp(SignUpRequest request);

    TokenResponse login(LoginRequest request);

    TokenResponse verify(VerifyUserRequest request);

    Response resendVerificationEmail(String email);

    TokenResponse refreshToken(TokenRequest request);

    Response forgotPassword(ForgotPasswordRequest request);

    Response introspect(TokenRequest request);
}
