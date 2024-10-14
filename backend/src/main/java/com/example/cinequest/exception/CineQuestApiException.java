package com.example.cinequest.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CineQuestApiException extends RuntimeException {
    private final boolean success;
    private final ApiResponseCode responseCode;

    public ApiResponseCode getApiResponseCode() {
        return responseCode;
    }
}
