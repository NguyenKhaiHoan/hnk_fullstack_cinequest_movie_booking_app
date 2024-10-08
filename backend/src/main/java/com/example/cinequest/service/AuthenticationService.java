package com.example.cinequest.service;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.model.request.LoginRequest;
import com.example.cinequest.model.request.SignUpRequest;
import com.example.cinequest.model.request.VerifyUserRequest;

public interface AuthenticationService {
    AppUser signup(SignUpRequest input);

    AppUser login(LoginRequest input);

    void verify(VerifyUserRequest input);

    void resendVerificationEmail(String email);
}