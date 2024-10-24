package com.example.cinequest.service.impl;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.UUID;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

import com.example.cinequest.constant.Constants;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.TokenResponse;
import com.example.cinequest.dto.request.*;
import com.example.cinequest.entity.Role;
import com.example.cinequest.entity.User;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.jwt.JwtModel;
import com.example.cinequest.jwt.JwtTokenProvider;
import com.example.cinequest.repository.RoleRepository;
import com.example.cinequest.repository.UserDetailsRepository;
import com.example.cinequest.repository.UserRepository;
import com.example.cinequest.service.AuthenticationService;
import com.example.cinequest.service.EmailService;
import com.example.cinequest.util.GenerateUtil;
import com.example.cinequest.util.ValidateUtil;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationServiceImpl implements AuthenticationService {
    UserRepository userRepository;
    EmailService emailService;
    JwtTokenProvider jwtTokenProvider;
    RoleRepository roleRepository;
    UserDetailsRepository userDetailsRepository;

    @Override
    public Response signUp(SignUpRequest request) {
        ValidateUtil.validateSignUpRequest(request);

        if (userRepository.existsByEmail(request.getEmail())) {
            throw new CineQuestApiException(false, ApiResponseCode.EMAIL_ALREADY_REGISTERED);
        }
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);
        User user = new User(request.getEmail(), passwordEncoder.encode(request.getPassword()));

        user.setVerificationCode(GenerateUtil.generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));
        user.setEnabled(false);

        Role userRole = roleRepository.findById(Constants.USER_ROLE).orElse(null);
        var roles = new HashSet<Role>();
        roles.add(userRole);
        user.setRoles(roles);

        userRepository.save(user);

        sendVerificationEmailWithHtmlTemplate(user);
        return new Response(
                true,
                ApiResponseCode.SIGN_UP_SUCCESS.getStatusCode(),
                ApiResponseCode.SIGN_UP_SUCCESS.getStatusMessage());
    }

    @Override
    public TokenResponse login(LoginRequest request) {
        if (!request.getEmail().startsWith("admin")) {
            ValidateUtil.validateLoginRequest(request);
        }

        User user = userRepository
                .findByEmail(request.getEmail())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        if (!user.isEnabled()) {
            throw new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_VERIFIED);
        }

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);
        boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());

        if (!authenticated) {
            throw new CineQuestApiException(false, ApiResponseCode.BAD_CREDENTIALS);
        }

        JwtModel accessToken = jwtTokenProvider.generateToken(user);

        return new TokenResponse(accessToken.getToken(), accessToken.getTokenExpiresAt());
    }

    @Override
    public TokenResponse verify(VerifyUserRequest request) {
        ValidateUtil.validateEmail(request.getEmail());

        User user = userRepository
                .findByEmail(request.getEmail())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.VERIFY_ACCOUNT_FAIL));

        if (user.getVerificationCodeExpiresAt().isBefore(LocalDateTime.now())) {
            throw new CineQuestApiException(false, ApiResponseCode.EMAIL_VERIFICATION_CODE_EXPIRED);
        }

        if (user.getVerificationCode().equals(request.getVerificationCode())) {

            JwtModel accessToken = jwtTokenProvider.generateToken(user);

            user.setEnabled(true);
            user.setVerificationCode(null);
            user.setVerificationCodeExpiresAt(null);
            userRepository.save(user);

            return new TokenResponse(accessToken.getToken(), accessToken.getTokenExpiresAt());
        } else {
            throw new CineQuestApiException(false, ApiResponseCode.EMAIL_VERIFICATION_CODE_INVALID);
        }
    }

    @Override
    public Response resendVerificationEmail(String email) {
        ValidateUtil.validateEmail(email);

        User user = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));

        if (user.isEnabled()) {
            throw new CineQuestApiException(false, ApiResponseCode.ACCOUNT_ALREADY_VERIFIED);
        }

        user.setVerificationCode(GenerateUtil.generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));

        resendVerificationEmail(user);
        userRepository.save(user);

        return new Response(
                true,
                ApiResponseCode.VERIFICATION_CODE_SENT.getStatusCode(),
                ApiResponseCode.VERIFICATION_CODE_SENT.getStatusMessage());
    }

    @Override
    public TokenResponse refreshToken(TokenRequest request) {
        var signedJWT = jwtTokenProvider.verifyToken(request.getToken(), true);

        try {
            var email = signedJWT.getJWTClaimsSet().getSubject();

            User user = userRepository
                    .findByEmail(email)
                    .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

            JwtModel accessToken = jwtTokenProvider.generateToken(user);
            return new TokenResponse(accessToken.getToken(), accessToken.getTokenExpiresAt());
        } catch (ParseException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }

    @Override
    public Response forgotPassword(ForgotPasswordRequest request) {
        User user = userRepository
                .findByEmail(request.getEmail())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        user.setResetPasswordFormId(UUID.randomUUID().toString());
        user.setResetPasswordFormExpiresAt(LocalDateTime.now().plusMinutes(5));

        sendResetPasswordEmail(user);
        userRepository.save(user);

        return new Response(
                true,
                ApiResponseCode.EMAIL_RESET_PASSWORD_SENT.getStatusCode(),
                ApiResponseCode.EMAIL_RESET_PASSWORD_SENT.getStatusMessage());
    }

    @Override
    public Response introspect(TokenRequest request) {
        boolean isValid = true;
        try {
            jwtTokenProvider.verifyToken(request.getToken(), false);
        } catch (CineQuestApiException exception) {
            isValid = false;
        }

        return new Response(
                true,
                isValid
                        ? ApiResponseCode.VALID_JWT_TOKEN.getStatusCode()
                        : ApiResponseCode.INVALID_JWT_TOKEN.getStatusCode(),
                isValid
                        ? ApiResponseCode.VALID_JWT_TOKEN.getStatusMessage()
                        : ApiResponseCode.INVALID_JWT_TOKEN.getStatusMessage());
    }

    private void resendVerificationEmail(User user) {
        String subject = "Email Verification";
        Context context = new Context();
        context.setVariable("verificationCode", user.getVerificationCode());

        emailService.sendVerificationEmailWithHtmlTemplate(
                user.getEmail(), subject, "resend-verification-email", context);
    }

    private void sendVerificationEmailWithHtmlTemplate(User user) {
        String subject = "Email Verification";
        Context context = new Context();
        context.setVariable("verificationCode", user.getVerificationCode());

        emailService.sendVerificationEmailWithHtmlTemplate(user.getEmail(), subject, "verification-email", context);
    }

    private void sendResetPasswordEmail(User user) {
        String subject = "Reset Password";
        Context context = new Context();

        context.setVariable(
                "resetPasswordLink", Constants.SERVER_BASE_URL + "/reset-password/" + user.getResetPasswordFormId());

        emailService.sendVerificationEmailWithHtmlTemplate(user.getEmail(), subject, "reset-password-email", context);
    }
}
