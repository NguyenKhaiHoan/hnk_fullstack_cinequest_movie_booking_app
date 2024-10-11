package com.example.cinequest.dto.repsonse;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Response {
    @JsonProperty("success")
    private boolean success;

    @JsonProperty("status_code")
    private int statusCode;

    @JsonProperty("status_message")
    private String statusMessage;
}
