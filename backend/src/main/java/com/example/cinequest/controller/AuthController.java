package com.example.cinequest.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.exception.EnumException;
import com.example.cinequest.model.repsonse.LoginResponse;
import com.example.cinequest.model.repsonse.Response;
import com.example.cinequest.model.request.LoginRequest;
import com.example.cinequest.model.request.ResendEmailRequest;
import com.example.cinequest.model.request.SignUpRequest;
import com.example.cinequest.model.request.VerifyUserRequest;
import com.example.cinequest.security.JwtTokenProvider;
import com.example.cinequest.service.AuthenticationService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final JwtTokenProvider jwtTokenProvider;

    private final AuthenticationService authenticationService;

    @PostMapping("/signup")
    public Response register(@RequestBody SignUpRequest request) {
        AppUser user = authenticationService.signup(request);
        final EnumException exception = EnumException.SUCCESS;
        return new Response(true, exception.getStatusCode(),
                user.getVerificationCode());
    }

    @PostMapping("/login")
    public LoginResponse authenticate(@RequestBody LoginRequest request) {
        AppUser user = authenticationService.login(request);
        String jwtToken = jwtTokenProvider.generateToken(user);
        return new LoginResponse(jwtToken, jwtTokenProvider.getExpirationTime(), "",
                jwtTokenProvider.getExpirationTime());
    }

    @PostMapping("/verify")
    public Response verifyUser(@RequestBody VerifyUserRequest request) {
        try {
            authenticationService.verify(request);
            final EnumException exception = EnumException.SUCCESS;
            return new Response(true, exception.getStatusCode(),
                    "Your account has been successfully verified. You can now log in.");
        } catch (CinequestApiException exception) {
            return new Response(false, exception.getStatusCode(), exception.getMessage());
        }
    }

    @PostMapping("/resend")
    public Response resendVerificationEmail(@RequestBody ResendEmailRequest request) {
        try {
            authenticationService.resendVerificationEmail(request.getEmail());
            final EnumException exception = EnumException.SUCCESS;
            return new Response(true, exception.getStatusCode(),
                    "A new verification code has been sent. Please check!");
        } catch (CinequestApiException exception) {
            return new Response(false, exception.getStatusCode(), exception.getMessage());
        }
    }
}
