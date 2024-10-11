package com.example.cinequest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.cinequest.dto.repsonse.MovieListResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.AddFavoriteRequest;
import com.example.cinequest.dto.request.MovieListRequest;
import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.service.FavoriteMovieService;
import com.example.cinequest.service.ProfilePhotoService;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/account/")
public class AccountController {

    @Autowired
    private FavoriteMovieService favoriteMovieService;
    @Autowired
    private ProfilePhotoService profilePhotoService;

    @PostMapping("/favorite")
    public ResponseEntity<Response> addFavorite(@RequestBody AddFavoriteRequest request) {
        favoriteMovieService.addFavorite(request);
        final ApiResponseCode responseCode = ApiResponseCode.FAVORITE_MOVIE_ADDED_SUCCESS;

        return ResponseEntity.ok(new Response(true, responseCode.getStatusCode(), responseCode.getStatusMessage()));
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
    public String getUserDetails(@RequestBody String entity) {
        // TODO: process GET request
        return entity;
    }

    @PostMapping("/save")
    public String saveUserDetails(@RequestBody String entity) {
        // TODO: process POST request
        return entity;
    }

    @PostMapping("profile-photo/upload")
    public ResponseEntity<Response> uploadProfilePhoto(@RequestParam("profile_photo") MultipartFile file,
            HttpServletRequest request) {
        profilePhotoService.uploadProfilePhoto(file, request);
        final ApiResponseCode responseCode = ApiResponseCode.FAVORITE_MOVIE_ADDED_SUCCESS;

        return ResponseEntity.ok(new Response(true, responseCode.getStatusCode(), responseCode.getStatusMessage()));
    }

}
