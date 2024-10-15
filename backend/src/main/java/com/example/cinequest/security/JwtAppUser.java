package com.example.cinequest.security;

import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.model.JwtModel;
import com.example.cinequest.repository.AppUserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Component
public class JwtAppUser {
    private final JwtTokenProvider jwtTokenProvider;
    private final AppUserRepository userRepository;

    public JwtModel getJwtModel(HttpServletRequest request) throws CineQuestApiException {
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new CineQuestApiException(false,
                    ApiResponseCode.UNAUTHORIZED_ACCESS);
        }

        String token = authHeader.substring(7);

        String userEmail = jwtTokenProvider.extractUsername(token);

        return new JwtModel(userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new CineQuestApiException(false,
                        ApiResponseCode.USER_NOT_FOUND)),
                token);
    }

    public boolean isNotAdmin(HttpServletRequest httpServletRequest) {
        String authHeader = httpServletRequest.getHeader(HttpHeaders.AUTHORIZATION);

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new CineQuestApiException(false,
                    ApiResponseCode.UNAUTHORIZED_ACCESS);
        }

        String token = authHeader.substring(7);
        String role = jwtTokenProvider.extractRole(token);
        return !"ADMIN".equals(role);
    }
}
