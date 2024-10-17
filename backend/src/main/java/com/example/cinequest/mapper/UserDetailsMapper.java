package com.example.cinequest.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

import com.example.cinequest.dto.repsonse.UserDetailsResponse;
import com.example.cinequest.dto.request.UserDetailsRequest;
import com.example.cinequest.entity.UserDetails;

@Mapper(componentModel = "spring")
public interface UserDetailsMapper {
    UserDetailsResponse toUserDetailsResponse(UserDetails userDetails);

    void updateUserDetails(@MappingTarget UserDetails userDetails, UserDetailsRequest request);
}
