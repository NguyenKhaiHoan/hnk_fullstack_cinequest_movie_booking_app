package com.example.cinequest.model.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SignUpRequest {
    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;
}