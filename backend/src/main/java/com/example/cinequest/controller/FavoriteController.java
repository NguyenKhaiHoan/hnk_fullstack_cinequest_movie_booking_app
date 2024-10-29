package com.example.cinequest.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.cinequest.dto.repsonse.MovieListResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.MovieRequest;
import com.example.cinequest.service.MovieService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("/favorite")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class FavoriteController {
    MovieService movieService;

    @PostMapping("/{user_id}/add")
    public ResponseEntity<Response> addFavorite(
            @PathVariable("user_id") String userId, @RequestBody MovieRequest request) {
        Response response = movieService.addFavorite(request, userId);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/{user_id}/delete/{movie_id}")
    public ResponseEntity<Response> addFavorite(
            @PathVariable("user_id") String userId, @PathVariable("movie_id") Long movieId) {
        Response response = movieService.deleteFavorite(movieId, userId);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{user_id}")
    public ResponseEntity<MovieListResponse> getFavorites(
            @PathVariable("user_id") String userId,
            @RequestParam(value = "language", defaultValue = "en-US") String language,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "limit", defaultValue = "20") int limit) {
        MovieListResponse response = movieService.getMovies(language, page, limit, userId);
        return ResponseEntity.ok(response);
    }
}
