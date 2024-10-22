package com.example.cinequest.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.UserDetailsResponse;
import com.example.cinequest.dto.request.UserDetailsRequest;
import com.example.cinequest.entity.User;
import com.example.cinequest.entity.UserDetails;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.jwt.JwtTokenProvider;
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
    private static final Logger log = LoggerFactory.getLogger(UserDetailsService.class);
    UserRepository userRepository;
    UserDetailsRepository userDetailsRepository;
    ProfilePhotoService profilePhotoService;
    JwtTokenProvider jwtTokenProvider;

    UserDetailsMapper userDetailsMapper;

    public Response setupAccount(UserDetailsRequest request, MultipartFile file, String email) {
        jwtTokenProvider.validateSelfRequestByEmail(email, userRepository);

        UserDetails userDetails = profilePhotoService.uploadProfilePhotoToFileSystem(file, email);
        request.setProfilePhoto(userDetails.getProfilePhoto());

        UserDetails newUserDetails = updateUserDetails(request, userDetails.getId());
        log.info(newUserDetails.getUsername());
        return new Response(
                true,
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusCode(),
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusMessage());
    }

    public Response updateUserDetails(UserDetailsRequest request, MultipartFile file, String userId) {
        jwtTokenProvider.validateSelfRequestById(userId, userRepository);

        User user = userRepository
                .findById(userId)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        UserDetails userDetails = profilePhotoService.uploadProfilePhotoToFileSystem(file, user.getEmail());
        request.setProfilePhoto(userDetails.getProfilePhoto());

        UserDetails newUserDetails = updateUserDetails(request, userDetails.getId());
        log.info(newUserDetails.getUsername());

        return new Response(
                true,
                ApiResponseCode.USER_DETAILS_UPDATE_SUCCESS.getStatusCode(),
                ApiResponseCode.USER_DETAILS_UPDATE_SUCCESS.getStatusMessage());
    }

    private UserDetails updateUserDetails(UserDetailsRequest request, String userId) {
        UserDetails userDetails = userDetailsRepository.findById(userId).orElse(new UserDetails());

        userDetailsMapper.updateUserDetails(userDetails, request);

        return userDetailsRepository.save(userDetails);
    }

    public UserDetailsResponse getUserDetails(String userId) {
        jwtTokenProvider.validateSelfRequestById(userId, userRepository);

        UserDetailsResponse response = userDetailsMapper.toUserDetailsResponse(userDetailsRepository
                .findById(userId)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND)));

        response.setProfilePhoto(profilePhotoService.encodeProfilePhoto(response.getProfilePhoto()));
        return response;
    }
}
