package com.example.cinequest.dto.repsonse;

import java.util.Set;

import com.example.cinequest.entity.Role;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserResponse {
    @JsonProperty("id")
    private String id;

    @JsonProperty("email")
    private String email;

    @JsonProperty("enabled")
    private boolean enabled;

    @JsonProperty("roles")
    Set<Role> roles;
}
