package com.example.cinequest.service.impl;

import com.example.cinequest.entity.RefreshToken;
import com.example.cinequest.repository.RefreshTokenRepository;
import com.example.cinequest.security.JwtTokenProvider;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;

import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.model.request.ForgotPasswordRequest;
import com.example.cinequest.model.request.LoginRequest;
import com.example.cinequest.model.request.SignUpRequest;
import com.example.cinequest.model.request.VerifyUserRequest;
import com.example.cinequest.repository.AppUserRepository;
import com.example.cinequest.service.AuthenticationService;
import com.example.cinequest.service.EmailService;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.regex.Pattern;

@AllArgsConstructor
@Service
public class AuthenticationServiceImpl implements AuthenticationService {
    private final AppUserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final EmailService emailService;
    private final RefreshTokenRepository refreshTokenRepository;
    private final JwtTokenProvider jwtTokenProvider;

    @Override
    public AppUser signup(SignUpRequest request) throws CinequestApiException {
        validateSignUpRequest(request);

        if (userRepository.existsByEmail(request.getEmail())) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.EMAIL_ALREADY_REGISTERED.getStatusCode(),
                    ApiResponseCode.EMAIL_ALREADY_REGISTERED.getHttpStatusCode(),
                    ApiResponseCode.EMAIL_ALREADY_REGISTERED.getStatusMessage());
        }

        AppUser user = new AppUser(request.getEmail(), passwordEncoder.encode(request.getPassword()));

        user.setVerificationCode(generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));
        user.setEnabled(false);

        sendVerificationEmailWithHtmlTemplate(user);

        return userRepository.save(user);
    }

    @Override
    public AppUser login(LoginRequest request) throws CinequestApiException {
        validateLoginRequest(request);

        AppUser user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CinequestApiException(
                        false,
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED.getStatusCode(),
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED.getHttpStatusCode(),
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED.getStatusMessage()));

        if (!user.isEnabled()) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.ACCOUNT_NOT_VERIFIED.getStatusCode(),
                    ApiResponseCode.ACCOUNT_NOT_VERIFIED.getHttpStatusCode(),
                    ApiResponseCode.ACCOUNT_NOT_VERIFIED.getStatusMessage());
        }

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));

        return user;
    }

    @Override
    public void verify(VerifyUserRequest request) throws CinequestApiException {
        validateEmail(request.getEmail());

        AppUser user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CinequestApiException(
                        false,
                        ApiResponseCode.VERIFY_ACCOUNT_FAIL.getStatusCode(),
                        ApiResponseCode.VERIFY_ACCOUNT_FAIL.getHttpStatusCode(),
                        ApiResponseCode.VERIFY_ACCOUNT_FAIL.getStatusMessage()));

        if (user.getVerificationCodeExpiresAt().isBefore(LocalDateTime.now())) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_EXPIRED.getStatusCode(),
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_EXPIRED.getHttpStatusCode(),
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_EXPIRED.getStatusMessage());
        }

        if (user.getVerificationCode().equals(request.getVerificationCode())) {
            user.setEnabled(true);
            user.setVerificationCode(null);
            user.setVerificationCodeExpiresAt(null);
            userRepository.save(user);
        } else {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_INVALID.getStatusCode(),
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_INVALID.getHttpStatusCode(),
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_INVALID.getStatusMessage());
        }
    }

    @Override
    public void resendVerificationEmail(String email) throws CinequestApiException {
        validateEmail(email);

        AppUser user = userRepository.findByEmail(email)
                .orElseThrow(() -> new CinequestApiException(
                        false,
                        ApiResponseCode.USER_NOT_FOUND.getStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getHttpStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getStatusMessage()));

        if (user.isEnabled()) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.ACCOUNT_ALREADY_VERIFIED.getStatusCode(),
                    ApiResponseCode.ACCOUNT_ALREADY_VERIFIED.getHttpStatusCode(),
                    ApiResponseCode.ACCOUNT_ALREADY_VERIFIED.getStatusMessage());
        }

        user.setVerificationCode(generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));
        sendVerificationEmail(user);
        userRepository.save(user);
    }

    @Override
    public AppUser refreshToken(HttpServletRequest request) throws CinequestApiException {
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new CinequestApiException(false,
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusCode(),
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getHttpStatusCode(),
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusMessage());
        }

        String token = authHeader.substring(7);

        String userEmail = jwtTokenProvider.extractUsername(token);

        AppUser user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new CinequestApiException(false,
                        ApiResponseCode.USER_NOT_FOUND.getStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getHttpStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getStatusMessage()));

        if (jwtTokenProvider.isRefreshTokenValid(token, user)) {
            throw new CinequestApiException(false,
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusCode(),
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getHttpStatusCode(),
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusMessage());
        }
        SecurityContextHolder.clearContext();

        return user;
    }

    @Override
    public void forgotPassword(ForgotPasswordRequest request) {
        validateForgotPasswordRequest(request);

        AppUser user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CinequestApiException(
                        false,
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED.getStatusCode(),
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED.getHttpStatusCode(),
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED.getStatusMessage()));

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }

    public void saveToken(String token, String email) throws CinequestApiException {
        RefreshToken refreshToken = refreshTokenRepository.findByEmail(email).orElse(new RefreshToken());

        refreshToken.setEmail(email);
        refreshToken.setRefreshToken(token);
        refreshToken.setRefreshTokenExpiresAt(LocalDateTime.now().plusDays(3));

        refreshTokenRepository.save(refreshToken);
    }

    private void sendVerificationEmail(AppUser user) throws CinequestApiException {
        String subject = "Email Verification";
        String text = "Welcome to Cinequest - Movie Booking App!\nPlease enter the verification code below to continue: "
                + user.getVerificationCode();

        try {
            emailService.sendVerificationEmail(user.getEmail(), subject, text);
        } catch (MessagingException e) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.USER_NOT_FOUND.getStatusCode(),
                    ApiResponseCode.USER_NOT_FOUND.getHttpStatusCode(),
                    ApiResponseCode.USER_NOT_FOUND.getStatusMessage());
        }
    }

    private void sendVerificationEmailWithHtmlTemplate(AppUser user) throws CinequestApiException {
        String subject = "Email Verification";
        Context context = new Context();
        context.setVariable("verificationCode", user.getVerificationCode());

        try {
            emailService.sendVerificationEmailWithHtmlTemplate(user.getEmail(), subject, "verification-email-template",
                    context);
        } catch (MessagingException e) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.USER_NOT_FOUND.getStatusCode(),
                    ApiResponseCode.USER_NOT_FOUND.getHttpStatusCode(),
                    ApiResponseCode.USER_NOT_FOUND.getStatusMessage());
        }
    }

    private String generateVerificationCode() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    private void validateEmail(String email) throws CinequestApiException {
        final String EMAIL_REGEX = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        if (!Pattern.matches(EMAIL_REGEX, email)) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.INVALID_EMAIL_FORMAT.getStatusCode(),
                    ApiResponseCode.INVALID_EMAIL_FORMAT.getHttpStatusCode(),
                    ApiResponseCode.INVALID_EMAIL_FORMAT.getStatusMessage());
        }
    }

    private void validateSignUpRequest(SignUpRequest request) throws CinequestApiException {
        validateEmail(request.getEmail());
        validatePassword(request.getPassword());
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.PASSWORDS_DO_NOT_MATCH.getStatusCode(),
                    ApiResponseCode.PASSWORDS_DO_NOT_MATCH.getHttpStatusCode(),
                    ApiResponseCode.PASSWORDS_DO_NOT_MATCH.getStatusMessage());
        }
    }

    private void validateLoginRequest(LoginRequest request) throws CinequestApiException {
        validateEmail(request.getEmail());
        validatePassword(request.getPassword());
    }

    private void validateForgotPasswordRequest(ForgotPasswordRequest request) throws CinequestApiException {
        validateEmail(request.getEmail());
        validatePassword(request.getNewPassword());
    }

    private void validatePassword(String password) throws CinequestApiException {
        if (password.length() < 8) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.PASSWORD_TOO_SHORT.getStatusCode(),
                    ApiResponseCode.PASSWORD_TOO_SHORT.getHttpStatusCode(),
                    ApiResponseCode.PASSWORD_TOO_SHORT.getStatusMessage());
        }
        if (!password.matches(".*[A-Z].*")) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.PASSWORD_MISSING_UPPERCASE.getStatusCode(),
                    ApiResponseCode.PASSWORD_MISSING_UPPERCASE.getHttpStatusCode(),
                    ApiResponseCode.PASSWORD_MISSING_UPPERCASE.getStatusMessage());
        }
        if (!password.matches(".*\\d.*")) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.PASSWORD_MISSING_NUMBER.getStatusCode(),
                    ApiResponseCode.PASSWORD_MISSING_NUMBER.getHttpStatusCode(),
                    ApiResponseCode.PASSWORD_MISSING_NUMBER.getStatusMessage());
        }
        if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            throw new CinequestApiException(
                    false,
                    ApiResponseCode.PASSWORD_MISSING_SPECIAL.getStatusCode(),
                    ApiResponseCode.PASSWORD_MISSING_SPECIAL.getHttpStatusCode(),
                    ApiResponseCode.PASSWORD_MISSING_SPECIAL.getStatusMessage());
        }
    }
}
