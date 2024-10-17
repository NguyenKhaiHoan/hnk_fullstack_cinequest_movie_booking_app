package com.example.cinequest.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.UserDetailsResponse;
import com.example.cinequest.dto.request.UserDetailsRequest;
import com.example.cinequest.entity.User;
import com.example.cinequest.entity.UserDetails;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.mapper.UserDetailsMapper;
import com.example.cinequest.repository.UserDetailsRepository;
import com.example.cinequest.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserDetailsService {
    UserRepository userRepository;
    UserDetailsRepository userDetailsRepository;
    ProfilePhotoService profilePhotoService;

    UserDetailsMapper userDetailsMapper;

    public Response setupAccount(UserDetailsRequest request, MultipartFile file, String email) {
        UserDetails userDetails = profilePhotoService.uploadProfilePhotoToFileSystem(file, email);
        request.setProfilePhoto(userDetails.getProfilePhoto());

        updateUserDetails(request, userDetails.getId());

        return new Response(
                true,
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusCode(),
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusMessage());
    }

    public Response updateUserDetails(UserDetailsRequest request, MultipartFile file, String userId) {
        User user = userRepository
                .findById(userId)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));

        UserDetails userDetails = profilePhotoService.uploadProfilePhotoToFileSystem(file, user.getEmail());
        request.setProfilePhoto(userDetails.getProfilePhoto());

        updateUserDetails(request, userDetails.getId());

        return new Response(
                true,
                ApiResponseCode.USER_DETAILS_UPDATE_SUCCESS.getStatusCode(),
                ApiResponseCode.USER_DETAILS_UPDATE_SUCCESS.getStatusMessage());
    }

    private void updateUserDetails(UserDetailsRequest request, String userId) {
        UserDetails userDetails = userDetailsRepository.findById(userId).orElse(new UserDetails());

        userDetails.setUsername(request.getUsername());
        userDetails.setName(request.getName());
        userDetails.setSurname(request.getSurname());
        userDetails.setBio(request.getBio());
        userDetails.setProfilePhoto(request.getProfilePhoto());

        userDetailsRepository.save(userDetails);
    }

    public UserDetailsResponse getUserDetails(String userId) {
        return userDetailsMapper.toUserDetailsResponse(userDetailsRepository
                .findById(userId)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND)));
    }
}
