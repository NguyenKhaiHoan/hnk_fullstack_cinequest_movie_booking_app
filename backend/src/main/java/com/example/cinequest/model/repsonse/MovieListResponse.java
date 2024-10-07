package com.example.cinequest.model.repsonse;

import java.util.List;

import com.example.cinequest.entity.Movie;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MovieListResponse {
    @JsonProperty("page")
    private int page;

    @JsonProperty("results")
    private List<Movie> results;

    @JsonProperty("total_pages")
    private int totalPages;

    @JsonProperty("total_results")
    private int totalResults;
}
