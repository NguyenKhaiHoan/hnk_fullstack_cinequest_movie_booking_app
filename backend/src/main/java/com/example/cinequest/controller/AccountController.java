package com.example.cinequest.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.model.repsonse.MovieListResponse;
import com.example.cinequest.model.repsonse.Response;
import com.example.cinequest.model.request.AddFavoriteRequest;
import com.example.cinequest.model.request.MovieListRequest;
import com.example.cinequest.service.FavoriteMovieService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@RestController
@RequestMapping("/api/account/")
public class AccountController {

    private final FavoriteMovieService favoriteMovieService;

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
}
