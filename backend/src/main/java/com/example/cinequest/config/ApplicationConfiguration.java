package com.example.cinequest.config;

import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.repository.AppUserRepository;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;

@Configuration
@AllArgsConstructor
public class ApplicationConfiguration {
    private final AppUserRepository appUserRepository;

    @Bean
    UserDetailsService userDetailsService() throws CineQuestApiException {
        return username -> appUserRepository.findByEmail(username)
                .orElseThrow(() -> new CineQuestApiException(false,
                        ApiResponseCode.USER_NOT_FOUND));
    }
}
