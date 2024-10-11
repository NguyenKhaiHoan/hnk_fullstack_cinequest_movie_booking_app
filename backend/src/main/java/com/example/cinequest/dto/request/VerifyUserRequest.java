package com.example.cinequest.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VerifyUserRequest {
    @JsonProperty("email")
    private String email;

    @JsonProperty("verification_code")
    private String verificationCode;
}