package com.example.cinequest.service;

import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.entity.User;
import com.example.cinequest.entity.UserDetails;

public interface ProfilePhotoService {
    User uploadProfilePhoto(MultipartFile file, String email);

    byte[] downloadProfilePhoto(String userId);

    UserDetails uploadProfilePhotoToFileSystem(MultipartFile file, String email);

    byte[] downloadProfilePhotoFromFileSystem(String userId);
}
