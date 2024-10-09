package com.example.cinequest.service.impl;

import jakarta.mail.MessagingException;
import lombok.AllArgsConstructor;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.model.request.LoginRequest;
import com.example.cinequest.model.request.SignUpRequest;
import com.example.cinequest.model.request.VerifyUserRequest;
import com.example.cinequest.repository.AppUserRepository;
import com.example.cinequest.service.AuthenticationService;
import com.example.cinequest.service.EmailService;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

@AllArgsConstructor
@Service
public class AuthenticationServiceImpl implements AuthenticationService {
    private final AppUserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    private final AuthenticationManager authenticationManager;

    private final EmailService emailService;

    @Override
    public AppUser signup(SignUpRequest input) throws CinequestApiException {
        AppUser user = new AppUser(input.getEmail(), passwordEncoder.encode(input.getPassword()));

        user.setVerificationCode(generateVerificationCode());
        user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));
        user.setEnabled(false);

        sendVerificationEmailWithHtmlTemplate(user);

        return userRepository.save(user);
    }

    @Override
    public AppUser login(LoginRequest input) throws CinequestApiException {
        AppUser user = userRepository.findByEmail(input.getEmail())
                .orElseThrow(() -> {
                    final ApiResponseCode responseCode = ApiResponseCode.ACCOUNT_NOT_REGISTERED;
                    throw new CinequestApiException(
                            false,
                            responseCode.getStatusCode(),
                            responseCode.getHttpStatusCode(),
                            responseCode.getStatusMessage());
                });

        if (!user.isEnabled()) {
            final ApiResponseCode responseCode = ApiResponseCode.ACCOUNT_NOT_VERIFIED;
            throw new CinequestApiException(
                    false,
                    responseCode.getStatusCode(),
                    responseCode.getHttpStatusCode(),
                    responseCode.getStatusMessage());
        }
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        input.getEmail(),
                        input.getPassword()));

        return user;
    }

    @Override
    public void verify(VerifyUserRequest input) throws CinequestApiException {
        Optional<AppUser> optionalUser = userRepository.findByEmail(input.getEmail());

        if (optionalUser.isPresent()) {
            AppUser user = optionalUser.get();
            if (user.getVerificationCodeExpiresAt().isBefore(LocalDateTime.now())) {
                final ApiResponseCode responseCode = ApiResponseCode.EMAIL_VERIFICATION_CODE_EXPIRED;
                throw new CinequestApiException(false, responseCode.getStatusCode(), responseCode.getHttpStatusCode(),
                        responseCode.getStatusMessage());
            }

            if (user.getVerificationCode().equals(input.getVerificationCode())) {
                user.setEnabled(true);
                user.setVerificationCode(null);
                user.setVerificationCodeExpiresAt(null);
                userRepository.save(user);
            } else {
                final ApiResponseCode responseCode = ApiResponseCode.EMAIL_VERIFICATION_CODE_INVALID;
                throw new CinequestApiException(false, responseCode.getStatusCode(), responseCode.getHttpStatusCode(),
                        responseCode.getStatusMessage());
            }
        } else {
            final ApiResponseCode responseCode = ApiResponseCode.VERIFY_ACCOUNT_FAIL;
            throw new CinequestApiException(false, responseCode.getStatusCode(), responseCode.getHttpStatusCode(),
                    responseCode.getStatusMessage());
        }
    }

    @Override
    public void resendVerificationEmail(String email) throws CinequestApiException {
        Optional<AppUser> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isPresent()) {
            AppUser user = optionalUser.get();

            if (user.isEnabled()) {
                final ApiResponseCode responseCode = ApiResponseCode.ACCOUNT_ALREADY_VERIFIED;
                throw new CinequestApiException(false, responseCode.getStatusCode(), responseCode.getHttpStatusCode(),
                        responseCode.getStatusMessage());
            }

            user.setVerificationCode(generateVerificationCode());
            user.setVerificationCodeExpiresAt(LocalDateTime.now().plusMinutes(5));

            sendVerificationEmail(user);
            userRepository.save(user);
        } else {
            final ApiResponseCode responseCode = ApiResponseCode.USER_NOT_FOUND;
            throw new CinequestApiException(
                    false,
                    responseCode.getStatusCode(),
                    responseCode.getHttpStatusCode(),
                    responseCode.getStatusMessage());
        }
    }

    private void sendVerificationEmail(AppUser user) throws CinequestApiException {
        String subject = "Email Verification";
        String verificationCode = user.getVerificationCode();
        String text = "Welcome back Cinequest - Movie Booking App!\nPlease enter the verification code below to continue: "
                + verificationCode;

        try {
            emailService.sendVerificationEmail(user.getEmail(), subject, text);
        } catch (MessagingException e) {
            e.printStackTrace();
            final ApiResponseCode responseCode = ApiResponseCode.USER_NOT_FOUND;
            throw new CinequestApiException(
                    false,
                    responseCode.getStatusCode(),
                    responseCode.getHttpStatusCode(),
                    responseCode.getStatusMessage());
        }
    }

    private void sendVerificationEmailWithHtmlTemplate(AppUser user) throws CinequestApiException {
        String subject = "Email Verification";
        Context context = new Context();
        String verificationCode = user.getVerificationCode();
        context.setVariable("verificationCode", verificationCode);

        try {
            emailService.sendVerificationEmailWithHtmlTemplate(user.getEmail(), subject, "verification-email-template",
                    context);

        } catch (MessagingException e) {
            e.printStackTrace();
            final ApiResponseCode responseCode = ApiResponseCode.USER_NOT_FOUND;
            throw new CinequestApiException(
                    false,
                    responseCode.getStatusCode(),
                    responseCode.getHttpStatusCode(),
                    responseCode.getStatusMessage());
        }
    }

    private String generateVerificationCode() {
        Random random = new Random();
        return String.valueOf(random.nextInt(999999));
    }
}