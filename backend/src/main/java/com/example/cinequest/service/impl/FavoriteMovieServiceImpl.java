package com.example.cinequest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.CinequestApiException;
import com.example.cinequest.exception.EnumException;
import com.example.cinequest.model.request.AddFavoriteRequest;
import com.example.cinequest.model.request.MovieListRequest;
import com.example.cinequest.repository.FavoriteMovieRepository;
import com.example.cinequest.service.FavoriteMovieService;

@Service
public class FavoriteMovieServiceImpl implements FavoriteMovieService {
    @Autowired
    private FavoriteMovieRepository favoriteMovieRepository;

    @Override
    public void addFavorite(AddFavoriteRequest request) throws CinequestApiException {
        final Movie movie = request.getMovie();
        final boolean favorite = request.isFavorite();
        final boolean exists = favoriteMovieRepository.existsById(movie.getId());
        if (favorite) {
            if (exists) {
                favoriteMovieRepository.deleteById(movie.getId());
                favoriteMovieRepository.save(movie);
                final EnumException exception = EnumException.RECORD_UPDATED_SUCCESS;
                throw new CinequestApiException(true, exception.getStatusCode(), exception.getHttpStatusCode(),
                        exception.getStatusMessage());
            }
            favoriteMovieRepository.save(movie);
        } else {
            if (!exists) {
                final EnumException exception = EnumException.RECORD_DELETED_SUCCESS;
                throw new CinequestApiException(true, exception.getStatusCode(), exception.getHttpStatusCode(),
                        exception.getStatusMessage());
            }
            favoriteMovieRepository.delete(movie);
        }
    }

    @Override
    public List<Movie> getFavorites(MovieListRequest request) throws CinequestApiException {
        final int page = request.getPage();
        if (page < 0) {
            final EnumException exception = EnumException.INVALID_PAGE;
            throw new CinequestApiException(false, exception.getStatusCode(), exception.getHttpStatusCode(),
                    exception.getStatusMessage());
        }
        return favoriteMovieRepository.findAll();
    }
}
