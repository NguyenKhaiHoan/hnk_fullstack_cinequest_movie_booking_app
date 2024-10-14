package com.example.cinequest.service.impl;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.repository.AppUserRepository;
import com.example.cinequest.service.AppUserService;

import org.springframework.stereotype.Service;
import lombok.AllArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@Service
public class AppUserServiceImpl implements AppUserService {
    private final AppUserRepository appUserRepository;

    @Override
    public List<AppUser> getAppUsers() {
        return new ArrayList<>(appUserRepository.findAll());
    }
}