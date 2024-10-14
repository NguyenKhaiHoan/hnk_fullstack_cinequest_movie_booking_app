package com.example.cinequest.dto.repsonse;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class AuthResponse {
    @JsonProperty("access_token")
    private String accessToken;

    @JsonProperty("access_expiration")
    private Long accessTokenExpiresAt;

    @JsonProperty("refresh_token")
    private String refreshToken;

    @JsonProperty("refresh_expiration")
    private Long refreshTokenExpiresAt;
}