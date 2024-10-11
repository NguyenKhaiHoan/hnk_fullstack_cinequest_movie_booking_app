package com.example.cinequest.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MovieListRequest {
    @JsonProperty("language")
    private String language;

    @JsonProperty("page")
    private int page;
}
