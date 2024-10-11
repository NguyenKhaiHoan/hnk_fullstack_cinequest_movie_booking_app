package com.example.cinequest.service.impl;

import com.example.cinequest.entity.AppUser;
import com.example.cinequest.repository.AppUserRepository;
import com.example.cinequest.service.AppUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService {
    @Autowired
    private AppUserRepository appUserRepository;

    @Override
    public List<AppUser> getAppUsers() {
        List<AppUser> users = new ArrayList<>();
        appUserRepository.findAll().forEach(users::add);
        return users;
    }
}