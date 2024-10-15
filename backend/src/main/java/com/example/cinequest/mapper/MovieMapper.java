package com.example.cinequest.mapper;

import com.example.cinequest.dto.MovieDTO;
import com.example.cinequest.entity.Movie;
import org.springframework.stereotype.Component;

@Component
public class MovieMapper {
    public MovieDTO convertToDTO(Movie movie) {
        if (movie == null) {
            return null;
        }

        return MovieDTO.builder()
                .id(movie.getId())
                .adult(movie.isAdult())
                .backdropPath(movie.getBackdropPath())
                .genreIds(movie.getGenreIds())
                .originalLanguage(movie.getOriginalLanguage())
                .originalTitle(movie.getOriginalTitle())
                .overview(movie.getOverview())
                .popularity(movie.getPopularity())
                .posterPath(movie.getPosterPath())
                .releaseDate(movie.getReleaseDate())
                .title(movie.getTitle())
                .video(movie.isVideo())
                .voteAverage(movie.getVoteAverage())
                .voteCount(movie.getVoteCount())
                .build();
    }

    public static Movie mapToEntity(MovieDTO movieDTO) {
        if (movieDTO == null) {
            return null;
        }

        return Movie.builder()
                .id(movieDTO.getId())
                .adult(movieDTO.isAdult())
                .backdropPath(movieDTO.getBackdropPath())
                .genreIds(movieDTO.getGenreIds())
                .originalLanguage(movieDTO.getOriginalLanguage())
                .originalTitle(movieDTO.getOriginalTitle())
                .overview(movieDTO.getOverview())
                .popularity(movieDTO.getPopularity())
                .posterPath(movieDTO.getPosterPath())
                .releaseDate(movieDTO.getReleaseDate())
                .title(movieDTO.getTitle())
                .video(movieDTO.isVideo())
                .voteAverage(movieDTO.getVoteAverage())
                .voteCount(movieDTO.getVoteCount())
                .build();
    }
}
