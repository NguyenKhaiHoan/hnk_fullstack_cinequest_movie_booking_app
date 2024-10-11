package com.example.cinequest.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.cinequest.entity.ProfilePhoto;

public interface ProfilePhotoRepository extends JpaRepository<ProfilePhoto, Long> {
}
