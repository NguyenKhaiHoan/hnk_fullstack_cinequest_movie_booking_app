package com.example.cinequest.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.cinequest.entity.AppUserDetails;

public interface AppUserDetailsRepository extends JpaRepository<AppUserDetails, Long> {
}
