package com.example.cinequest.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.constant.Constants;
import com.example.cinequest.entity.ProfilePhoto;
import com.example.cinequest.entity.User;
import com.example.cinequest.entity.UserDetails;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.repository.ProfilePhotoRepository;
import com.example.cinequest.repository.UserDetailsRepository;
import com.example.cinequest.repository.UserRepository;
import com.example.cinequest.service.ProfilePhotoService;
import com.example.cinequest.util.FileUtil;
import com.example.cinequest.util.ImageUtil;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ProfilePhotoServiceImpl implements ProfilePhotoService {
    private ProfilePhotoRepository photoRepository;
    private UserDetailsRepository userDetailsRepository;
    private UserRepository userRepository;

    @Override
    public User uploadProfilePhoto(MultipartFile file, String email) {
        User user = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));

        try {
            ProfilePhoto photo = ProfilePhoto.builder()
                    .name(file.getOriginalFilename())
                    .type(file.getContentType())
                    .photo(ImageUtil.compressImage(file.getBytes()))
                    .id(user.getId())
                    .build();
            photoRepository.save(photo);
            return user;
        } catch (IOException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }

    @Override
    public byte[] downloadProfilePhoto(String userId) {
        ProfilePhoto photo = photoRepository
                .findById(userId)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND));
        return ImageUtil.decompressImage(photo.getPhoto());
    }

    @Override
    public UserDetails uploadProfilePhotoToFileSystem(MultipartFile file, String email) {
        User user = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));

        String folderUserPath = Constants.STORAGE_PATH + File.separator + email;
        File userFolder = new File(folderUserPath);
        if (!userFolder.exists()) {
            boolean dirCreated = userFolder.mkdirs();
            if (!dirCreated) {
                throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
            }
        }

        String fileExtension = FileUtil.getFileExtension(Objects.requireNonNull(file.getOriginalFilename()));
        String fileName =
                Constants.PROFILE_PHOTO_PREFIX + user.getId() + "-" + System.currentTimeMillis() + fileExtension;
        String filePath = folderUserPath + File.separator + fileName;

        try {
            file.transferTo(new File(filePath));

            UserDetails userDetails = userDetailsRepository
                    .findById(user.getId())
                    .orElseGet(() -> UserDetails.builder().id(user.getId()).build());

            userDetails.setProfilePhoto(filePath);

            userDetailsRepository.save(userDetails);

            return userDetails;
        } catch (Exception e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }

    @Override
    public byte[] downloadProfilePhotoFromFileSystem(String userId) {
        UserDetails userDetails = userDetailsRepository
                .findById(userId)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        String path = userDetails.getProfilePhoto();
        byte[] images;

        try {
            images = Files.readAllBytes(new File(path).toPath());
        } catch (IOException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
        return images;
    }

    @Override
    public String encodeProfilePhoto(String path) {
        File file = new File(path);
        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            throw new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND);
        }

        byte[] imageBytes = new byte[(int) file.length()];
        try {
            int result = fileInputStream.read(imageBytes);
            if (result > 0) {
                log.info(String.valueOf(result));
            }
            String base64Image = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
            fileInputStream.close();

            return base64Image;
        } catch (IOException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }
}
