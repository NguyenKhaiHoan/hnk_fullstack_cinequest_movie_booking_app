package com.example.cinequest.mapper;

import org.mapstruct.Mapper;

import com.example.cinequest.dto.repsonse.UserResponse;
import com.example.cinequest.entity.User;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserResponse toUserResponse(User user);
}
