package com.example.cinequest.controller;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.cinequest.dto.repsonse.AuthResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.ForgotPasswordRequest;
import com.example.cinequest.dto.request.LoginRequest;
import com.example.cinequest.dto.request.ResendEmailRequest;
import com.example.cinequest.dto.request.SignUpRequest;
import com.example.cinequest.dto.request.VerifyUserRequest;
import com.example.cinequest.entity.AppUser;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.security.JwtTokenProvider;
import com.example.cinequest.service.AuthenticationService;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private JwtTokenProvider jwtTokenProvider;
    @Autowired
    private AuthenticationService authenticationService;

    @PostMapping("/signup")
    public ResponseEntity<Response> register(@RequestBody SignUpRequest request) {
        authenticationService.signup(request);
        final ApiResponseCode exception = ApiResponseCode.SIGN_UP_SUCCESS;

        return ResponseEntity.ok(new Response(true, exception.getStatusCode(),
                exception.getStatusMessage()));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest request) {
        AppUser user = authenticationService.login(request);
        String accessToken = jwtTokenProvider.generateToken(user, true);
        String refreshToken = jwtTokenProvider.generateToken(user, false);

        authenticationService.saveToken(refreshToken, user.getEmail());

        return ResponseEntity.ok(new AuthResponse(accessToken, jwtTokenProvider.getExpirationTime(true),
                refreshToken, jwtTokenProvider.getExpirationTime(false)));
    }

    @PostMapping("/verify")
    public ResponseEntity<Response> verifyUser(@RequestBody VerifyUserRequest request) {
        authenticationService.verify(request);

        final ApiResponseCode exception = ApiResponseCode.VERIFY_ACCOUNT_SUCCESS;
        return ResponseEntity.ok(new Response(true, exception.getStatusCode(), exception.getStatusMessage()));
    }

    @PostMapping("/resend-code")
    public ResponseEntity<Response> resendVerificationEmail(@RequestBody ResendEmailRequest request) {
        authenticationService.resendVerificationEmail(request.getEmail());
        final ApiResponseCode exception = ApiResponseCode.VERIFICATION_CODE_SENT;

        return ResponseEntity.ok(new Response(true, exception.getStatusCode(),
                exception.getStatusMessage()));
    }

    @PostMapping("/refresh-token")
    public ResponseEntity<AuthResponse> refreshToken(HttpServletRequest request) {
        AppUser user = authenticationService.refreshToken(request);

        String accessToken = jwtTokenProvider.generateToken(user, true);
        String refreshToken = jwtTokenProvider.generateToken(user, false);

        authenticationService.saveToken(refreshToken, user.getEmail());

        return ResponseEntity.ok(new AuthResponse(accessToken, jwtTokenProvider.getExpirationTime(true),
                refreshToken, jwtTokenProvider.getExpirationTime(false)));
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<Response> forgotPassword(@RequestBody ForgotPasswordRequest request) {
        authenticationService.forgotPassword(request);
        final ApiResponseCode exception = ApiResponseCode.RESET_PASSWORD_SUCCESS;

        return ResponseEntity.ok(new Response(true, exception.getStatusCode(),
                exception.getStatusMessage()));
    }
}
