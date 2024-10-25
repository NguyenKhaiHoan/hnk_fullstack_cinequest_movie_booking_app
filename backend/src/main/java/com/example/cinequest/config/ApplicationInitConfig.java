package com.example.cinequest.config;

import java.util.HashSet;

import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.cinequest.constant.Constants;
import com.example.cinequest.entity.Role;
import com.example.cinequest.entity.User;
import com.example.cinequest.entity.UserDetails;
import com.example.cinequest.repository.RoleRepository;
import com.example.cinequest.repository.UserDetailsRepository;
import com.example.cinequest.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ApplicationInitConfig {
    PasswordEncoder passwordEncoder;

    @Bean
    @ConditionalOnProperty(value = "spring.datasource.driver-class-name", havingValue = "com.mysql.cj.jdbc.Driver")
    ApplicationRunner applicationRunner(
            UserRepository userRepository, UserDetailsRepository userDetailsRepository, RoleRepository roleRepository) {
        return args -> {
            String adminEmail = "admin@cinequest.com";
            String adminPassword = "admin";

            if (userRepository.findByEmail(adminEmail).isEmpty()) {
                roleRepository.save(Role.builder()
                        .name(Constants.USER_ROLE)
                        .description("User role")
                        .build());

                Role adminRole = roleRepository.save(Role.builder()
                        .name(Constants.ADMIN_ROLE)
                        .description("Admin role")
                        .build());

                var roles = new HashSet<Role>();
                roles.add(adminRole);

                User admin = User.builder()
                        .email(adminEmail)
                        .password(passwordEncoder.encode(adminPassword))
                        .enabled(true)
                        .roles(roles)
                        .build();
                userRepository.save(admin);

                UserDetails adminDetails = UserDetails.builder()
                        .id(admin.getId())
                        .username("admin")
                        .name("Admin")
                        .surname("CineQuest")
                        .bio("Admin of CineQuest")
                        .build();
                userDetailsRepository.save(adminDetails);
            }
        };
    }
}
