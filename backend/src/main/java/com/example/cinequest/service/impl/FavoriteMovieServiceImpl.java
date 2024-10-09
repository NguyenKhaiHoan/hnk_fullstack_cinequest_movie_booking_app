package com.example.cinequest.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.model.request.AddFavoriteRequest;
import com.example.cinequest.model.request.MovieListRequest;
import com.example.cinequest.repository.FavoriteMovieRepository;
import com.example.cinequest.service.FavoriteMovieService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class FavoriteMovieServiceImpl implements FavoriteMovieService {
    private final FavoriteMovieRepository favoriteMovieRepository;

    @Override
    public void addFavorite(AddFavoriteRequest request) throws CinequestApiException {
        final Movie movie = request.getMovie();
        final boolean favorite = request.isFavorite();
        final boolean exists = favoriteMovieRepository.existsById(movie.getId());

        if (favorite) {
            if (exists) {
                favoriteMovieRepository.deleteById(movie.getId());
                favoriteMovieRepository.save(movie);

                final ApiResponseCode responseCode = ApiResponseCode.FAVORITE_MOVIE_UPDATED_SUCCESS;

                throw new CinequestApiException(true, responseCode.getStatusCode(), responseCode.getHttpStatusCode(),
                        responseCode.getStatusMessage());
            }

            favoriteMovieRepository.save(movie);
        } else {
            if (!exists) {
                final ApiResponseCode responseCode = ApiResponseCode.FAVORITE_MOVIE_REMOVED_SUCCESS;

                throw new CinequestApiException(true, responseCode.getStatusCode(), responseCode.getHttpStatusCode(),
                        responseCode.getStatusMessage());
            }

            favoriteMovieRepository.delete(movie);
        }
    }

    @Override
    public List<Movie> getFavorites(MovieListRequest request) throws CinequestApiException {
        int page = request.getPage();

        if (page < 1) {
            final ApiResponseCode responseCode = ApiResponseCode.INVALID_PAGE_NUMBER;

            throw new CinequestApiException(false, responseCode.getStatusCode(),
                    responseCode.getHttpStatusCode(), responseCode.getStatusMessage());
        }

        List<Movie> movies = favoriteMovieRepository.findAll();

        if (movies == null || movies.isEmpty()) {
            return new ArrayList<>();
        }

        final int limit = 20;
        final int totalResults = movies.size();
        final int totalPages = (int) Math.ceil((double) totalResults / limit);

        if (page > totalPages) {
            return new ArrayList<>();
        }

        final int start = (page - 1) * limit;
        final int end = Math.min(start + limit, totalResults);
        return movies.subList(start, end);
    }

    @Override
    public int getFavoritesSize() {
        List<Movie> movies = favoriteMovieRepository.findAll();

        if (movies == null || movies.isEmpty()) {
            return 0;
        }

        return movies.size();
    }
}
