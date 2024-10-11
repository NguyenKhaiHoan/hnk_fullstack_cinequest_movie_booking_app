package com.example.cinequest.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRequest {
    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;
}