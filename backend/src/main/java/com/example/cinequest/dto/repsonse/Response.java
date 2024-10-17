package com.example.cinequest.dto.repsonse;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Response {
    @JsonProperty("success")
    boolean success;

    @JsonProperty("status_code")
    int statusCode;

    @JsonProperty("status_message")
    String statusMessage;
}
