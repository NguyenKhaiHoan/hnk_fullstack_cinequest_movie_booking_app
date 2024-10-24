package com.example.cinequest.service;

import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.UserDetailsResponse;
import com.example.cinequest.dto.request.UserDetailsRequest;

public interface UserDetailsService {
    Response setupAccount(UserDetailsRequest request, MultipartFile file, String email);

    Response updateUserDetails(UserDetailsRequest request, MultipartFile file, String userId);

    UserDetailsResponse getUserDetails(String userId);
}
