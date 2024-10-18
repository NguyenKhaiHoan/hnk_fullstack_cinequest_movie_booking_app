package com.example.cinequest.dto.repsonse;

import java.util.List;

import com.example.cinequest.dto.MovieDTO;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
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
