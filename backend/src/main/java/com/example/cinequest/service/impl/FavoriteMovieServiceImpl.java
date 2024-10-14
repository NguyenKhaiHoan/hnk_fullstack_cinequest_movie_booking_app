package com.example.cinequest.service.impl;

import com.example.cinequest.dto.request.AddFavoriteRequest;
import com.example.cinequest.dto.request.MovieListRequest;
import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.repository.FavoriteMovieRepository;
import com.example.cinequest.service.FavoriteMovieService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@Service
public class FavoriteMovieServiceImpl implements FavoriteMovieService {
    private FavoriteMovieRepository favoriteMovieRepository;

    @Override
    public void addFavorite(AddFavoriteRequest request) throws CineQuestApiException {
        final Movie movie = request.getMovie();
        final boolean favorite = request.isFavorite();
        final boolean exists = favoriteMovieRepository.existsById(movie.getId());

        if (favorite) {
            if (exists) {
                favoriteMovieRepository.deleteById(movie.getId());
                favoriteMovieRepository.save(movie);

                throw new CineQuestApiException(true, ApiResponseCode.FAVORITE_MOVIE_UPDATED_SUCCESS);
            }

            favoriteMovieRepository.save(movie);
        } else {
            if (!exists) {

                throw new CineQuestApiException(true, ApiResponseCode.FAVORITE_MOVIE_REMOVED_SUCCESS);
            }

            favoriteMovieRepository.delete(movie);
        }
    }

    @Override
    public List<Movie> getFavorites(MovieListRequest request) throws CineQuestApiException {
        int page = request.getPage();

        if (page < 1) {
            throw new CineQuestApiException(false, ApiResponseCode.INVALID_PAGE_NUMBER);
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
