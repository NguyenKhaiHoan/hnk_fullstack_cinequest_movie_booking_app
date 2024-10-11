package com.example.cinequest.config;

import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CinequestApiException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.example.cinequest.repository.AppUserRepository;

@Configuration
public class ApplicationConfiguration {
    @Autowired
    private AppUserRepository appUserRepository;

    @Bean
    UserDetailsService userDetailsService() throws CinequestApiException {
        return username -> appUserRepository.findByEmail(username)
                .orElseThrow(() -> new CinequestApiException(false,
                        ApiResponseCode.USER_NOT_FOUND.getStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getHttpStatusCode(),
                        ApiResponseCode.USER_NOT_FOUND.getStatusMessage()));
    }

    @Bean
    BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());

        return new ProviderManager(authProvider);
    }
}
