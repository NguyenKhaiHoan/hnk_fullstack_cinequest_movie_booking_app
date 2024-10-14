package com.example.cinequest.repository;

import com.example.cinequest.entity.AppUserDetails;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppUserDetailsRepository extends JpaRepository<AppUserDetails, Long> {
}
