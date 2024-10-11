package com.example.cinequest.dto.request;

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
public class AddFavoriteRequest {
    @JsonProperty("movie")
    private Movie movie;

    @JsonProperty("favorite")
    private boolean favorite;
}
