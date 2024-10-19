package com.example.cinequest.service;

import com.example.cinequest.dto.repsonse.MovieListResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.MovieRequest;

public interface MovieService {
    Response addFavorite(MovieRequest request, String userId);

    Response deleteFavorite(Long movieId, String userId);

    MovieListResponse getMovies(String language, int page, int limit, String userId);
}
