package com.example.cinequest.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.repsonse.UserDetailsResponse;
import com.example.cinequest.dto.repsonse.UserResponse;
import com.example.cinequest.dto.request.UserDetailsRequest;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.service.ProfilePhotoService;
import com.example.cinequest.service.UserDetailsService;
import com.example.cinequest.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("/account")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AccountController {
    ProfilePhotoService profilePhotoService;
    UserDetailsService userDetailsService;
    UserService userService;

    @GetMapping
    public ResponseEntity<UserResponse> getUser() {
        var context = SecurityContextHolder.getContext();
        String email = context.getAuthentication().getName();

        UserResponse response = userService.getUser(email);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/setup")
    public ResponseEntity<Response> setupAccount(
            @RequestParam("profile_photo") MultipartFile file, @RequestParam("user_details") String userDetailsJson) {

        var context = SecurityContextHolder.getContext();
        String email = context.getAuthentication().getName();

        UserDetailsRequest request = mapUserDetailsRequest(userDetailsJson);
        Response response = userDetailsService.setupAccount(request, file, email);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/details/{user_id}")
    public ResponseEntity<UserDetailsResponse> getUserDetails(@PathVariable("user_id") String userId) {
        UserDetailsResponse response = userDetailsService.getUserDetails(userId);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/details/{user_id}")
    public ResponseEntity<Response> updateUserDetails(
            @PathVariable("user_id") String userId,
            @RequestParam("profile_photo") MultipartFile file,
            @RequestParam("user_details") String userDetailsJson) {

        UserDetailsRequest request = mapUserDetailsRequest(userDetailsJson);
        Response response = userDetailsService.updateUserDetails(request, file, userId);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/details/{user_id}/profile-photo")
    public ResponseEntity<byte[]> downloadImageFromFileSystem(@PathVariable("user_id") String userId) {
        byte[] imageData = profilePhotoService.downloadProfilePhotoFromFileSystem(userId);
        return ResponseEntity.ok().contentType(MediaType.valueOf("image/png")).body(imageData);
    }

    private UserDetailsRequest mapUserDetailsRequest(String userDetailsJson) {
        UserDetailsRequest request;

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            request = objectMapper.readValue(userDetailsJson, UserDetailsRequest.class);
        } catch (JsonProcessingException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }

        return request;
    }
}
