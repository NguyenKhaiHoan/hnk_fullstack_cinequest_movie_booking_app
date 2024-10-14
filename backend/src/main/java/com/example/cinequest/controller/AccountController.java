package com.example.cinequest.controller;

import com.example.cinequest.dto.repsonse.AppUserDetailsResponse;
import com.example.cinequest.dto.repsonse.MovieListResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.AddFavoriteRequest;
import com.example.cinequest.dto.request.AddUserDetailsRequest;
import com.example.cinequest.dto.request.MovieListRequest;
import com.example.cinequest.entity.AppUser;
import com.example.cinequest.entity.AppUserDetails;
import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.service.AppUserDetailsService;
import com.example.cinequest.service.FavoriteMovieService;
import com.example.cinequest.service.ProfilePhotoService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/account/")
public class AccountController {
    private final FavoriteMovieService favoriteMovieService;
    private final ProfilePhotoService profilePhotoService;
    private final AppUserDetailsService appUserDetailsService;

    @PostMapping("/favorite")
    public ResponseEntity<Response> addFavorite(@RequestBody AddFavoriteRequest request) {
        favoriteMovieService.addFavorite(request);

        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.FAVORITE_MOVIE_ADDED_SUCCESS.getStatusCode(),
                ApiResponseCode.FAVORITE_MOVIE_ADDED_SUCCESS.getStatusMessage()));
    }

    @GetMapping("/favorite/movies")
    public ResponseEntity<MovieListResponse> getFavorites(
            @RequestBody MovieListRequest request) {
        final List<Movie> movies = favoriteMovieService.getFavorites(request);
        final int limit = 20;

        final int totalResults = favoriteMovieService.getFavoritesSize();
        final int totalPages = (int) Math.ceil((double) totalResults / limit);

        return ResponseEntity.ok(new MovieListResponse(request.getPage(), movies, totalPages, totalResults));
    }

    @GetMapping("")
    public ResponseEntity<AppUserDetailsResponse> getUserDetails(HttpServletRequest httpServletRequest) {
        AppUserDetails userDetails = appUserDetailsService.getUserDetails(httpServletRequest);
        return ResponseEntity.ok(new AppUserDetailsResponse(userDetails.getUsername(), userDetails.getName(),
                userDetails.getSurname(), userDetails.getBio(), userDetails.getProfilePhoto()));
    }

    @Transactional
    @PostMapping("/save")
    public ResponseEntity<Response> addOrUpdateUserDetails(
            @RequestParam("profile_photo") MultipartFile file,
            @RequestParam("details") String detailsJson,
            HttpServletRequest httpServletRequest) {

        ObjectMapper objectMapper = new ObjectMapper();
        AddUserDetailsRequest request;

        try {
            request = objectMapper.readValue(detailsJson, AddUserDetailsRequest.class);
        } catch (IOException e) {
            return ResponseEntity.badRequest().body(new Response(false, 400, "Invalid JSON format"));
        }

        AppUser user = profilePhotoService.uploadProfilePhotoToFileSystem(file, httpServletRequest);
        appUserDetailsService.addOrUpdateUserDetails(request, user);

        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusCode(),
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusMessage()));
    }

    @GetMapping("/profile-photo")
    public ResponseEntity<byte[]> downloadImageFromFileSystem(HttpServletRequest httpServletRequest) {
        byte[] imageData = profilePhotoService.downloadProfilePhotoFromFileSystem(httpServletRequest);
        return ResponseEntity.ok()
                .contentType(MediaType.valueOf("image/png")).body(imageData);
    }
}
