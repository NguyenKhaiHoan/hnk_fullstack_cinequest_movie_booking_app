package com.example.cinequest.service;

import java.util.List;

import com.example.cinequest.entity.Movie;
import com.example.cinequest.model.request.AddFavoriteRequest;
import com.example.cinequest.model.request.MovieListRequest;

public interface FavoriteMovieService {
    void addFavorite(AddFavoriteRequest request);

    List<Movie> getFavorites(MovieListRequest request);

    int getFavoritesSize();
}
