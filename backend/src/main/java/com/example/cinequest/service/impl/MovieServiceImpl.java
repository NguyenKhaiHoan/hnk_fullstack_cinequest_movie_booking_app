package com.example.cinequest.service.impl;

import com.example.cinequest.dto.MovieDTO;
import com.example.cinequest.dto.request.AddMovieRequest;
import com.example.cinequest.dto.request.MovieListRequest;
import com.example.cinequest.entity.Movie;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.mapper.MovieMapper;
import com.example.cinequest.repository.MovieRepository;
import com.example.cinequest.security.JwtAppUser;
import com.example.cinequest.service.MovieService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@Service
public class MovieServiceImpl implements MovieService {
    private final MovieRepository movieRepository;
    private final MovieMapper movieMapper;
    private final JwtAppUser jwtAppUser;

    @Override
    public void addMovie(AddMovieRequest request, String operation, HttpServletRequest httpServletRequest) throws CineQuestApiException {

        if (jwtAppUser.isNotAdmin(httpServletRequest)) {
            throw new CineQuestApiException(false, ApiResponseCode.ADMIN_ONLY);
        }

        MovieDTO movieDTO = request.getMovie();
        Movie movie = MovieMapper.mapToEntity(movieDTO);

        final boolean exists = movieRepository.existsById(movie.getId());

        if (operation.equals("add") || operation.equals("update")) {
            if (exists) {
                Movie existedMovie = movieRepository.findById(movie.getId()).orElse(new Movie());
                existedMovie
                        .setAdult(movie.isAdult());existedMovie
                        .setBackdropPath(movie.getBackdropPath());existedMovie
                        .setGenreIds(movie.getGenreIds());existedMovie
                        .setOriginalLanguage(movie.getOriginalLanguage());existedMovie
                        .setOriginalTitle(movie.getOriginalTitle());existedMovie
                        .setOverview(movie.getOverview());existedMovie
                        .setPopularity(movie.getPopularity());existedMovie
                        .setPosterPath(movie.getPosterPath());existedMovie
                        .setReleaseDate(movie.getReleaseDate());existedMovie
                        .setTitle(movie.getTitle());existedMovie
                        .setVideo(movie.isVideo());existedMovie
                        .setVoteAverage(movie.getVoteAverage());existedMovie
                        .setVoteCount(movie.getVoteCount());
                movieRepository.save(existedMovie);
                return;
            }
            movieRepository.save(movie);
        } else {
            if (!exists) {
                throw new CineQuestApiException(true, ApiResponseCode.FAVORITE_MOVIE_NOT_FOUND);
            }
            movieRepository.delete(movie);
        }
    }

    @Override
    public List<MovieDTO> getMovies(MovieListRequest request, HttpServletRequest httpServletRequest) throws CineQuestApiException {

        if (jwtAppUser.isNotAdmin(httpServletRequest)) {
            throw new CineQuestApiException(false, ApiResponseCode.ADMIN_ONLY);
        }

        int page = request.getPage();

        if (page < 1) {
            throw new CineQuestApiException(false, ApiResponseCode.INVALID_PAGE_NUMBER);
        }

        List<Movie> movies = movieRepository.findAll();

        if (movies.isEmpty()) {
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

        return movies.subList(start, end).stream()
                .map(movieMapper::convertToDTO)
                .toList();
    }

    @Override
    public int getMoviesSize() {
        return (int) movieRepository.count();
    }
}
