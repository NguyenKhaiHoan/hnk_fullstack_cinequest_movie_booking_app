package com.example.cinequest.exception;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CinequestApiException extends RuntimeException {
    @JsonProperty("success")
    private final boolean success;

    @JsonProperty("status_code")
    private final int statusCode;

    @JsonProperty("http_status_code")
    private final int httpStatusCode;

    @JsonProperty("status_message")
    private final String statusMessage;
}
