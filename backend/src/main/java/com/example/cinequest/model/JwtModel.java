package com.example.cinequest.model;

import com.example.cinequest.entity.AppUser;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class JwtModel {
    private AppUser user;
    private String token;
}
