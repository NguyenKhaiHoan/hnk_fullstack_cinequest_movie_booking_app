package com.example.cinequest.service;

import java.util.List;

import com.example.cinequest.dto.request.AddFavoriteRequest;
import com.example.cinequest.dto.request.MovieListRequest;
import com.example.cinequest.entity.Movie;

public interface FavoriteMovieService {
    void addFavorite(AddFavoriteRequest request);

    List<Movie> getFavorites(MovieListRequest request);

    int getFavoritesSize();
}
