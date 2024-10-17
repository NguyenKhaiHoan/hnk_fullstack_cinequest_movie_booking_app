package com.example.cinequest.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SignUpRequest {
    @JsonProperty("email")
    String email;

    @JsonProperty("password")
    String password;

    @JsonProperty("confirm_password")
    String confirmPassword;
}
