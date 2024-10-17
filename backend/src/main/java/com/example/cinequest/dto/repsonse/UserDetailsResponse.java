package com.example.cinequest.dto.repsonse;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserDetailsResponse {
    @JsonProperty("username")
    String username;

    @JsonProperty("name")
    String name;

    @JsonProperty("surname")
    String surname;

    @JsonProperty("bio")
    String bio;

    @JsonProperty("profile_photo")
    String profilePhoto;
}
