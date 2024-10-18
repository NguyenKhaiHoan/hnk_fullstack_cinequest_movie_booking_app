package com.example.cinequest.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.cinequest.dto.repsonse.MovieListResponse;
import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.dto.request.MovieRequest;
import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.jwt.JwtTokenProvider;
import com.example.cinequest.mapper.MovieMapper;
import com.example.cinequest.repository.MovieRepository;
import com.example.cinequest.repository.UserRepository;
import com.example.cinequest.service.MovieService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class MovieServiceImpl implements MovieService {
    MovieRepository movieRepository;
    MovieMapper movieMapper;
    JwtTokenProvider jwtTokenProvider;
    UserRepository userRepository;

    public Response addFavorite(MovieRequest request, String userId) {
        jwtTokenProvider.validateSelfRequestById(userId, userRepository);

        Movie movie = movieRepository.findById(request.getId()).orElse(new Movie());

        movieMapper.updateMovie(movie, request);

        if (movie.getUserIds() == null) {
            movie.setUserIds(new HashSet<>());
        }

        movie.getUserIds().add(userId);
        movieRepository.save(movie);

        return new Response(
                true,
                ApiResponseCode.FAVORITE_MOVIE_ADDED_SUCCESS.getStatusCode(),
                ApiResponseCode.FAVORITE_MOVIE_ADDED_SUCCESS.getStatusMessage());
    }

    @Override
    public Response deleteFavorite(Long movieId, String userId) {
        jwtTokenProvider.validateSelfRequestById(userId, userRepository);

        Movie movie = movieRepository
                .findById(movieId)
                .orElseThrow(() -> new CineQuestApiException(true, ApiResponseCode.FAVORITE_MOVIE_NOT_FOUND));

        movie.getUserIds().remove(userId);

        if (movie.getUserIds().isEmpty()) {
            movieRepository.deleteById(movieId);
        } else {
            movieRepository.save(movie);
        }

        return new Response(
                true,
                ApiResponseCode.FAVORITE_MOVIE_REMOVED_SUCCESS.getStatusCode(),
                ApiResponseCode.FAVORITE_MOVIE_REMOVED_SUCCESS.getStatusMessage());
    }

    @Override
    public MovieListResponse getMovies(String language, int page, String userId) {
        jwtTokenProvider.validateSelfRequestById(userId, userRepository);

        if (page < 1) {
            throw new CineQuestApiException(false, ApiResponseCode.INVALID_PAGE_NUMBER);
        }

        List<Movie> movies = movieRepository.findMoviesByUserId(userId);

        if (movies.isEmpty()) {
            return new MovieListResponse(1, new ArrayList<>(), 1, 0);
        }

        final int limit = 20;
        final int totalResults = movies.size();
        final int totalPages = (int) Math.ceil((double) totalResults / limit);

        if (page > totalPages) {
            return new MovieListResponse(1, new ArrayList<>(), 1, 0);
        }

        final int start = (page - 1) * limit;
        final int end = Math.min(start + limit, totalResults);

        return new MovieListResponse(
                page,
                movies.subList(start, end).stream().map(movieMapper::toDTO).toList(),
                totalPages,
                totalResults);
    }
}
