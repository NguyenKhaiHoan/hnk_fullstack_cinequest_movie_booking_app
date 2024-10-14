package com.example.cinequest.service.impl;

import com.example.cinequest.constant.Constants;
import com.example.cinequest.entity.AppUser;
import com.example.cinequest.entity.AppUserDetails;
import com.example.cinequest.entity.ProfilePhoto;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.model.JwtModel;
import com.example.cinequest.repository.AppUserDetailsRepository;
import com.example.cinequest.repository.AppUserRepository;
import com.example.cinequest.repository.ProfilePhotoRepository;
import com.example.cinequest.security.JwtAppUser;
import com.example.cinequest.service.ProfilePhotoService;
import com.example.cinequest.util.FileUtil;
import com.example.cinequest.util.ImageUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Objects;

@AllArgsConstructor
@Service
public class ProfilePhotoServiceImpl implements ProfilePhotoService {
    private ProfilePhotoRepository photoRepository;
    private AppUserDetailsRepository appUserDetailsRepository;
    private AppUserRepository appUserRepository;
    private JwtAppUser jwtAppUser;

    @Override
    public AppUser uploadProfilePhoto(MultipartFile file, HttpServletRequest request) throws CineQuestApiException {
        JwtModel jwtModel = jwtAppUser.getJwtModel(request);

        AppUser user = appUserRepository.findById(jwtModel.getUser().getId())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));

        try {
            ProfilePhoto photo = ProfilePhoto.builder().name(file.getOriginalFilename()).type(file.getContentType())
                    .photo(ImageUtil.compressImage(file.getBytes())).userId(user.getId()).build();
            photoRepository.save(photo);
            return user;
        } catch (IOException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }

    @Override
    public byte[] downloadProfilePhoto(HttpServletRequest httpServletRequest) throws CineQuestApiException {
        JwtModel jwtModel = jwtAppUser.getJwtModel(httpServletRequest);

        ProfilePhoto photo = photoRepository.findById(jwtModel.getUser().getId())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.RESOURCE_NOT_FOUND));
        return ImageUtil.decompressImage(photo.getPhoto());
    }

    @Override
    public AppUser uploadProfilePhotoToFileSystem(MultipartFile file, HttpServletRequest httpServletRequest) {
        JwtModel jwtModel = jwtAppUser.getJwtModel(httpServletRequest);

        AppUser user = appUserRepository.findById(jwtModel.getUser().getId())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));

        String username = user.getUsername();

        String folderUserPath = Constants.STORAGE_PATH + File.separator + username;
        File userFolder = new File(folderUserPath);
        if (!userFolder.exists()) {
            boolean dirCreated = userFolder.mkdirs();
            if (!dirCreated) {
                throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
            }
        }

        String fileExtension = FileUtil.getFileExtension(Objects.requireNonNull(file.getOriginalFilename()));
        String fileName = Constants.PROFILE_PHOTO_PREFIX + user.getId() + "-" + System.currentTimeMillis()
                + fileExtension;
        String filePath = folderUserPath + File.separator + fileName;

        try {
            file.transferTo(new File(filePath));

            AppUserDetails userDetails = appUserDetailsRepository.findById(user.getId())
                    .orElseGet(() -> {
                        AppUserDetails newUserDetails = new AppUserDetails();
                        newUserDetails.setUserId(user.getId());
                        return newUserDetails;
                    });

            userDetails.setProfilePhoto(filePath);

            appUserDetailsRepository.save(userDetails);

            return user;
        } catch (Exception e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }

    @Override
    public byte[] downloadProfilePhotoFromFileSystem(HttpServletRequest httpServletRequest) {
        JwtModel jwtModel = jwtAppUser.getJwtModel(httpServletRequest);

        AppUserDetails userDetails = appUserDetailsRepository.findById(jwtModel.getUser().getId())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));
        String path = userDetails.getProfilePhoto();
        byte[] images;

        try {
            images = Files.readAllBytes(new File(path).toPath());
        } catch (IOException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
        return images;
    }
}
