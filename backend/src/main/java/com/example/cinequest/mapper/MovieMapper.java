package com.example.cinequest.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

import com.example.cinequest.dto.MovieDTO;
import com.example.cinequest.dto.request.MovieRequest;
import com.example.cinequest.entity.Movie;

@Mapper(componentModel = "spring")
public interface MovieMapper {
    MovieDTO toDTO(Movie movie);

    Movie toEntity(MovieDTO movieDTO);

    void updateMovie(@MappingTarget Movie movie, MovieRequest request);

    Movie toEntity(MovieRequest request);
}
