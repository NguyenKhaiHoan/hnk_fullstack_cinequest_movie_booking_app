package com.example.cinequest.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ResetPasswordRequest {
    @JsonProperty("current_password")
    String currentPassword;

    @JsonProperty("new_password")
    String newPassword;

    @JsonProperty("confirm_password")
    String confirmPassword;
}
