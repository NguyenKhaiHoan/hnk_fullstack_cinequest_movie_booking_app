package com.example.cinequest.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.exception.ApiResponseCode;
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
    public ResponseEntity<Response> register(@RequestBody SignUpRequest request) {
        authenticationService.signup(request);
        final ApiResponseCode exception = ApiResponseCode.SIGN_UP_SUCCESS;

        return ResponseEntity.ok(new Response(true, exception.getStatusCode(),
                exception.getStatusMessage()));
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> authenticate(@RequestBody LoginRequest request) {
        AppUser user = authenticationService.login(request);
        String jwtToken = jwtTokenProvider.generateToken(user);

        return ResponseEntity.ok(new LoginResponse(jwtToken, jwtTokenProvider.getExpirationTime(), "",
                jwtTokenProvider.getExpirationTime()));
    }

    @PostMapping("/verify")
    public ResponseEntity<Response> verifyUser(@RequestBody VerifyUserRequest request) {
        authenticationService.verify(request);

        final ApiResponseCode exception = ApiResponseCode.VERIFY_ACCOUNT_SUCCESS;
        return ResponseEntity.ok(new Response(true, exception.getStatusCode(), exception.getStatusMessage()));
    }

    @PostMapping("/resend")
    public ResponseEntity<Response> resendVerificationEmail(@RequestBody ResendEmailRequest request) {
        authenticationService.resendVerificationEmail(request.getEmail());
        final ApiResponseCode exception = ApiResponseCode.VERIFICATION_CODE_SENT;

        return ResponseEntity.ok(new Response(true, exception.getStatusCode(),
                exception.getStatusMessage()));
    }
}
