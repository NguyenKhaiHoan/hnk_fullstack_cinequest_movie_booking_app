package com.example.cinequest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.EnumException;
import com.example.cinequest.model.Response;
import com.example.cinequest.model.repsonse.MovieListResponse;
import com.example.cinequest.model.request.AddFavoriteRequest;
import com.example.cinequest.model.request.MovieListRequest;
import com.example.cinequest.service.FavoriteMovieService;

@RestController
@RequestMapping("/api/account/")
public class AccountController {

    @Autowired
    private FavoriteMovieService favoriteMovieService;

    @PostMapping("/{account_id}/favorite")
    public Response addFavorite(@PathVariable("account_id") String accountId, @RequestBody AddFavoriteRequest request) {
        favoriteMovieService.addFavorite(request);
        final EnumException exception = EnumException.SUCCESS;
        return new Response(true, exception.getStatusCode(), exception.getStatusMessage());
    }

    @GetMapping("/{account_id}/favorite/movies")
    public MovieListResponse getFavorites(@PathVariable("account_id") String accountId,
            @RequestParam(name = "language", defaultValue = "en-US") String language,
            @RequestParam(name = "page", defaultValue = "1") int page) {
        final int limit = 20;
        final MovieListRequest request = new MovieListRequest(language, page);
        final List<Movie> movies = favoriteMovieService.getFavorites(request);

        final int totalResults = movies.size();
        final int totalPages = (int) Math.ceil((double) totalResults / limit);

        final int start = (page - 1) * limit;
        final int end = Math.min(start + limit, totalResults);
        List<Movie> paginatedMovies = movies.subList(start, end);
        return new MovieListResponse(page, paginatedMovies, totalPages, totalResults);
    }
}
