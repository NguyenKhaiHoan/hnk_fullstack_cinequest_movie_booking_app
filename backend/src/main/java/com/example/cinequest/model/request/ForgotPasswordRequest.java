package com.example.cinequest.model.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ForgotPasswordRequest {
    @JsonProperty("email")
    private String email;

    @JsonProperty("new_password")
    private String newPassword;
}
