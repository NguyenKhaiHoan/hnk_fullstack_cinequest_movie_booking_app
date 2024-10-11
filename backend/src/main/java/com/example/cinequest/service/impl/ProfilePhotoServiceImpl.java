package com.example.cinequest.service.impl;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.entity.ProfilePhoto;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.model.JwtModel;
import com.example.cinequest.repository.ProfilePhotoRepository;
import com.example.cinequest.security.JwtAppUser;
import com.example.cinequest.service.ProfilePhotoService;
import com.example.cinequest.util.ImageUtil;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ProfilePhotoServiceImpl implements ProfilePhotoService {
    @Autowired
    private ProfilePhotoRepository photoRepository;
    @Autowired
    private JwtAppUser jwtAppUser;

    @Override
    public ProfilePhoto uploadProfilePhoto(MultipartFile file, HttpServletRequest request)
            throws CinequestApiException {

        try {
            jwtAppUser.getJwtModel(request);

            ProfilePhoto photo = ProfilePhoto.builder()
                    .photo(ImageUtil.compressImage(file.getBytes()))
                    .build();

            return photoRepository.save(photo);
        } catch (CinequestApiException exception) {
            throw exception;
        } catch (IOException exception) {
            throw new CinequestApiException(false, ApiResponseCode.INTERNAL_ERROR.getStatusCode(),
                    ApiResponseCode.INTERNAL_ERROR.getHttpStatusCode(),
                    ApiResponseCode.INTERNAL_ERROR.getStatusMessage());
        }

    }

    @Override
    public byte[] getImage(HttpServletRequest request) {
        try {
            JwtModel jwtModel = jwtAppUser.getJwtModel(request);

            ProfilePhoto profilePhoto = photoRepository.findById(jwtModel.getUser().getId())
                    .orElseThrow(() -> new CinequestApiException(false,
                            ApiResponseCode.RESOURCE_NOT_FOUND.getStatusCode(),
                            ApiResponseCode.RESOURCE_NOT_FOUND.getHttpStatusCode(),
                            ApiResponseCode.RESOURCE_NOT_FOUND.getStatusMessage()));

            return ImageUtil.decompressImage(profilePhoto.getPhoto());
        } catch (CinequestApiException exception) {
            throw exception;
        }
    }

}
