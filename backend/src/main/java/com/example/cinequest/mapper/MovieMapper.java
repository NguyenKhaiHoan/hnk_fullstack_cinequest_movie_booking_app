package com.example.cinequest.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import com.example.cinequest.dto.MovieDTO;
import com.example.cinequest.dto.request.MovieRequest;
import com.example.cinequest.entity.Movie;

@Mapper(componentModel = "spring")
public interface MovieMapper {
    MovieDTO toDTO(Movie movie);

    @Mapping(target = "userIds", ignore = true)
    Movie toEntity(MovieDTO movieDTO);

    @Mapping(target = "userIds", ignore = true)
    void updateMovie(@MappingTarget Movie movie, MovieRequest request);

    @Mapping(target = "userIds", ignore = true)
    Movie toEntity(MovieRequest request);
}
