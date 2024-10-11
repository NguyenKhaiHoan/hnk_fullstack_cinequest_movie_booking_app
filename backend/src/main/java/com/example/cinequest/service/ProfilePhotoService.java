package com.example.cinequest.service;

import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.entity.ProfilePhoto;

import jakarta.servlet.http.HttpServletRequest;

public interface ProfilePhotoService {
    ProfilePhoto uploadProfilePhoto(MultipartFile file, HttpServletRequest request);

    byte[] getImage(HttpServletRequest request);
}
