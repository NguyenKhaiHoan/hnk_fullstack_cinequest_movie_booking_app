package com.example.cinequest.controller;

import com.example.cinequest.dto.MovieDTO;
import com.example.cinequest.dto.repsonse.AppUserDetailsResponse;
import com.example.cinequest.dto.repsonse.MovieListResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.AddFavoriteRequest;
import com.example.cinequest.dto.request.AddMovieRequest;
import com.example.cinequest.dto.request.AddUserDetailsRequest;
import com.example.cinequest.dto.request.MovieListRequest;
import com.example.cinequest.entity.AppUser;
import com.example.cinequest.entity.AppUserDetails;
import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.service.AppUserDetailsService;
import com.example.cinequest.service.MovieService;
import com.example.cinequest.service.ProfilePhotoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/account/")
public class AccountController {
    private final MovieService movieService;
    private final ProfilePhotoService profilePhotoService;
    private final AppUserDetailsService appUserDetailsService;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin")
    public ResponseEntity<String> adminEndpoint() {
        return ResponseEntity.ok("I am admin");
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/admin/add-movie")
    public ResponseEntity<Response> addMovie(@RequestBody AddMovieRequest request, HttpServletRequest httpServletRequest) {
        movieService.addMovie(request, "add", httpServletRequest);
        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.MOVIE_ADDED_SUCCESS.getStatusCode(),
                ApiResponseCode.MOVIE_ADDED_SUCCESS.getStatusMessage()));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/admin/update-movie")
    public ResponseEntity<Response> updateMovie(@RequestBody AddMovieRequest request , HttpServletRequest httpServletRequest) {
        movieService.addMovie(request, "update", httpServletRequest);
        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.MOVIE_UPDATED_SUCCESS.getStatusCode(),
                ApiResponseCode.MOVIE_UPDATED_SUCCESS.getStatusMessage()));
        
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/admin/remove-movie")
    public ResponseEntity<Response> removeFavorite(@RequestBody AddMovieRequest request, HttpServletRequest httpServletRequest) {
        movieService.addMovie(request, "remove", httpServletRequest);
        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.MOVIE_REMOVED_SUCCESS.getStatusCode(),
                ApiResponseCode.MOVIE_REMOVED_SUCCESS.getStatusMessage()));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/movie-list")
    public ResponseEntity<MovieListResponse> getMovies(@RequestBody MovieListRequest request, HttpServletRequest httpServletRequest) {
        final List<MovieDTO> movies = movieService.getMovies(request, httpServletRequest);
        final int limit = 20;
        final int totalResults = movieService.getMoviesSize();
        final int totalPages = (int) Math.ceil((double) totalResults / limit);

        return ResponseEntity.ok(new MovieListResponse(request.getPage(), movies, totalPages, totalResults));
    }

    @GetMapping("/details")
    public ResponseEntity<AppUserDetailsResponse> getUserDetails(HttpServletRequest httpServletRequest) {
        AppUserDetails userDetails = appUserDetailsService.getUserDetails(httpServletRequest);
        return ResponseEntity.ok(new AppUserDetailsResponse(userDetails.getUsername(), userDetails.getName(),
                userDetails.getSurname(), userDetails.getBio(), userDetails.getProfilePhoto()));
    }

    @PostMapping("/details/add")
    public ResponseEntity<Response> addUserDetails(
            @RequestParam("profile_photo") MultipartFile file,
            @RequestParam("details") String detailsJson,
            HttpServletRequest httpServletRequest) {

        try {
            addOrUpdateUserDetails(file, detailsJson, httpServletRequest);
        } catch (Exception exception) {
            return ResponseEntity.badRequest().body(new Response(false,
                    400,
                    "Invalid JSON format"));
        }

        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusCode(),
                ApiResponseCode.ACCOUNT_SETUP_SUCCESS.getStatusMessage()));
    }

    @PostMapping("/details/update")
    public ResponseEntity<Response> updateUserDetails(
            @RequestParam("profile_photo") MultipartFile file,
            @RequestParam("details") String detailsJson,
            HttpServletRequest httpServletRequest) {

        try {
            addOrUpdateUserDetails(file, detailsJson, httpServletRequest);
        } catch (Exception exception) {
            return ResponseEntity.badRequest().body(new Response(false,
                    400,
                    "Invalid JSON format"));
        }

        return ResponseEntity.ok(new Response(true,
                ApiResponseCode.ACCOUNT_UPDATE_SUCCESS.getStatusCode(),
                ApiResponseCode.ACCOUNT_UPDATE_SUCCESS.getStatusMessage()));
    }

    @GetMapping("/details/profile-photo")
    public ResponseEntity<byte[]> downloadImageFromFileSystem(HttpServletRequest httpServletRequest) {
        byte[] imageData = profilePhotoService.downloadProfilePhotoFromFileSystem(httpServletRequest);
        return ResponseEntity.ok()
                .contentType(MediaType.valueOf("image/png")).body(imageData);
    }

    private void addOrUpdateUserDetails(MultipartFile file, String detailsJson, HttpServletRequest httpServletRequest) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        AddUserDetailsRequest request;

        request = objectMapper.readValue(detailsJson, AddUserDetailsRequest.class);

        AppUser user = profilePhotoService.uploadProfilePhotoToFileSystem(file, httpServletRequest);
        appUserDetailsService.addOrUpdateUserDetails(request, user);
    }
}
