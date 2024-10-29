package com.example.cinequest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cinequest.entity.ProfilePhoto;

@Repository
public interface ProfilePhotoRepository extends JpaRepository<ProfilePhoto, String> {}
