package com.example.cinequest.dto.repsonse;

import com.example.cinequest.dto.MovieDTO;
import com.example.cinequest.entity.Movie;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class MovieListResponse {
    @JsonProperty("page")
    private int page;

    @JsonProperty("results")
    private List<MovieDTO> results;

    @JsonProperty("total_pages")
    private int totalPages;

    @JsonProperty("total_results")
    private int totalResults;
}
