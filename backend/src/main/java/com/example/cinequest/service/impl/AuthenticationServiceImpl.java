package com.example.cinequest.service.impl;

import com.example.cinequest.dto.request.ForgotPasswordRequest;
import com.example.cinequest.dto.request.LoginRequest;
import com.example.cinequest.dto.request.SignUpRequest;
import com.example.cinequest.dto.request.VerifyUserRequest;
import com.example.cinequest.entity.AppUser;
import com.example.cinequest.entity.RefreshToken;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.model.JwtModel;
import com.example.cinequest.repository.AppUserRepository;
import com.example.cinequest.repository.RefreshTokenRepository;
import com.example.cinequest.security.JwtAppUser;
import com.example.cinequest.security.JwtTokenProvider;
import com.example.cinequest.service.AuthenticationService;
import com.example.cinequest.service.EmailService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.regex.Pattern;

@AllArgsConstructor
@Service
public class AuthenticationServiceImpl implements AuthenticationService {
    private AppUserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private AuthenticationManager authenticationManager;
    private EmailService emailService;
    private RefreshTokenRepository refreshTokenRepository;
    private JwtTokenProvider jwtTokenProvider;
    private JwtAppUser jwtAppUser;

    @Override
    public void signUp(SignUpRequest request) throws CineQuestApiException {
        validateSignUpRequest(request);

        if (userRepository.existsByEmail(request.getEmail())) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.EMAIL_ALREADY_REGISTERED);
        }

        AppUser user = new AppUser(request.getEmail(), passwordEncoder.encode(request.getPassword()));

        user.setVerificationCode(generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));
        user.setEnabled(false);

        sendVerificationEmailWithHtmlTemplate(user);

        userRepository.save(user);
    }

    @Override
    public AppUser login(LoginRequest request) throws CineQuestApiException {
        if (!request.getEmail().startsWith("admin")) {
            validateLoginRequest(request);
        }

        AppUser user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CineQuestApiException(
                        false,
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        if (!user.isEnabled()) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.ACCOUNT_NOT_VERIFIED);
        }

       try {
           authenticationManager.authenticate(
                   new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword()));
       } catch (BadCredentialsException exception) {
            throw new CineQuestApiException(false, ApiResponseCode.BAD_CREDENTIALS);
       }

        return user;
    }

    @Override
    public void verify(VerifyUserRequest request) throws CineQuestApiException {
        validateEmail(request.getEmail());

        AppUser user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CineQuestApiException(
                        false,
                        ApiResponseCode.VERIFY_ACCOUNT_FAIL));

        if (user.getVerificationCodeExpiresAt().isBefore(LocalDateTime.now())) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_EXPIRED);
        }

        if (user.getVerificationCode().equals(request.getVerificationCode())) {
            user.setEnabled(true);
            user.setVerificationCode(null);
            user.setVerificationCodeExpiresAt(null);
            userRepository.save(user);
        } else {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.EMAIL_VERIFICATION_CODE_INVALID);
        }
    }

    @Override
    public void resendVerificationEmail(String email) throws CineQuestApiException {
        validateEmail(email);

        AppUser user = userRepository.findByEmail(email)
                .orElseThrow(() -> new CineQuestApiException(
                        false,
                        ApiResponseCode.USER_NOT_FOUND));

        if (user.isEnabled()) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.ACCOUNT_ALREADY_VERIFIED);
        }

        user.setVerificationCode(generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));
        sendVerificationEmail(user);
        userRepository.save(user);
    }

    @Override
    public AppUser refreshToken(HttpServletRequest request) throws CineQuestApiException {
        JwtModel jwtModel = jwtAppUser.getJwtModel(request);

        if (jwtTokenProvider.isRefreshTokenValid(jwtModel.getToken(), jwtModel.getUser())) {
            throw new CineQuestApiException(false,
                    ApiResponseCode.UNAUTHORIZED_ACCESS);
        }
        SecurityContextHolder.clearContext();

        return jwtModel.getUser();
    }

    @Override
    public void forgotPassword(ForgotPasswordRequest request) {
        validateForgotPasswordRequest(request);

        AppUser user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CineQuestApiException(
                        false,
                        ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }

    public void saveToken(String token, String email) throws CineQuestApiException {
        RefreshToken refreshToken = refreshTokenRepository.findByEmail(email).orElse(new RefreshToken());

        refreshToken.setEmail(email);
        refreshToken.setRefreshToken(token);
        refreshToken.setRefreshTokenExpiresAt(LocalDateTime.now().plusDays(3));

        refreshTokenRepository.save(refreshToken);
    }

    private void sendVerificationEmail(AppUser user) throws CineQuestApiException {
        String subject = "Email Verification";
        String text = "Welcome to Cinequest - Movie Booking App!\nPlease enter the verification code below to continue: "
                + user.getVerificationCode();

        emailService.sendVerificationEmail(user.getEmail(), subject, text);
    }

    private void sendVerificationEmailWithHtmlTemplate(AppUser user) throws CineQuestApiException {
        String subject = "Email Verification";
        Context context = new Context();
        context.setVariable("verificationCode", user.getVerificationCode());

        emailService.sendVerificationEmailWithHtmlTemplate(user.getEmail(), subject, "verification-email-template",
                context);
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int rValue = random.nextInt(999999);
        return String.format("%06d", rValue);
    }

    private void validateEmail(String email) throws CineQuestApiException {
        final String EMAIL_REGEX = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        if (!Pattern.matches(EMAIL_REGEX, email)) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.INVALID_EMAIL_FORMAT);
        }
    }

    private void validateSignUpRequest(SignUpRequest request) throws CineQuestApiException {
        validateEmail(request.getEmail());
        validatePassword(request.getPassword());
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.PASSWORDS_DO_NOT_MATCH);
        }
    }

    private void validateLoginRequest(LoginRequest request) throws CineQuestApiException {
        validateEmail(request.getEmail());
        validatePassword(request.getPassword());
    }

    private void validateForgotPasswordRequest(ForgotPasswordRequest request) throws CineQuestApiException {
        validateEmail(request.getEmail());
        validatePassword(request.getNewPassword());
    }

    private void validatePassword(String password) throws CineQuestApiException {
        if (password.length() < 8) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.PASSWORD_TOO_SHORT);
        }
        if (!password.matches(".*[A-Z].*")) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.PASSWORD_MISSING_UPPERCASE);
        }
        if (!password.matches(".*\\d.*")) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.PASSWORD_MISSING_NUMBER);
        }
        if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            throw new CineQuestApiException(
                    false,
                    ApiResponseCode.PASSWORD_MISSING_SPECIAL);
        }
    }
}
