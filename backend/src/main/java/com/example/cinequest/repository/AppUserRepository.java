package com.example.cinequest.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cinequest.entity.AppUser;

@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    Optional<AppUser> findByEmail(String email);

    Optional<AppUser> findByVerificationCode(String verificationCode);

    boolean existsByEmail(String email);
}