package com.example.cinequest.service;

import com.example.cinequest.dto.request.AddUserDetailsRequest;
import com.example.cinequest.entity.AppUser;
import com.example.cinequest.entity.AppUserDetails;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.model.JwtModel;
import com.example.cinequest.repository.AppUserDetailsRepository;
import com.example.cinequest.security.JwtAppUser;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@AllArgsConstructor
@Service
public class AppUserDetailsService {
    private final AppUserDetailsRepository appUserDetailsRepository;
    private final JwtAppUser jwtAppUser;

    public void addOrUpdateUserDetails(AddUserDetailsRequest request, AppUser user) {
        AppUserDetails userDetails = appUserDetailsRepository.findById(user.getId())
                .orElse(new AppUserDetails());

        userDetails.setUsername(request.getUsername());
        userDetails.setName(request.getName());
        userDetails.setSurname(request.getSurname());
        userDetails.setBio(request.getBio());

        appUserDetailsRepository.save(userDetails);
    }

    public AppUserDetails getUserDetails(HttpServletRequest request) throws CineQuestApiException {
        JwtModel jwtModel = jwtAppUser.getJwtModel(request);
        return appUserDetailsRepository.findById(jwtModel.getUser().getId())
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.USER_NOT_FOUND));
    }
}
