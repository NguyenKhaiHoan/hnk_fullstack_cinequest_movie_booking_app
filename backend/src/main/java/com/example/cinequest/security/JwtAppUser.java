package com.example.cinequest.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.model.JwtModel;
import com.example.cinequest.repository.AppUserRepository;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class JwtAppUser {
    @Autowired
    private JwtTokenProvider jwtTokenProvider;
    @Autowired
    private AppUserRepository userRepository;

    public JwtModel getJwtModel(HttpServletRequest request) throws CinequestApiException {
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new CinequestApiException(false,
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusCode(),
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getHttpStatusCode(),
                    ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusMessage());
        }

        String token = authHeader.substring(7);

        String userEmail = jwtTokenProvider.extractUsername(token);

        JwtModel jwtModel = new JwtModel(userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new CinequestApiException(false,
                        ApiResponseCode.USER_NOT_FOUND.getStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getHttpStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getStatusMessage())),
                token);

        return jwtModel;
    }
}
