package com.example.cinequest.service;

import com.example.cinequest.entity.AppUser;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

public interface ProfilePhotoService {
    AppUser uploadProfilePhoto(MultipartFile file, HttpServletRequest httpServletRequest);

    byte[] downloadProfilePhoto(HttpServletRequest httpServletRequest);

    AppUser uploadProfilePhotoToFileSystem(MultipartFile file, HttpServletRequest httpServletRequest);

    byte[] downloadProfilePhotoFromFileSystem(HttpServletRequest httpServletRequest);
}
