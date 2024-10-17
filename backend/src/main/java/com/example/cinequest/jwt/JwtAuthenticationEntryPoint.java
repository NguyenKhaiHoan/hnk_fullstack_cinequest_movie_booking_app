package com.example.cinequest.jwt;

import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import com.example.cinequest.dto.repsonse.Response;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(
            HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) {

        response.setStatus(ApiResponseCode.UNAUTHORIZED_ACCESS.getHttpStatusCode());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);

        Response apiResponse = new Response(
                false,
                ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusCode(),
                ApiResponseCode.UNAUTHORIZED_ACCESS.getStatusMessage());

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            response.getWriter().write(objectMapper.writeValueAsString(apiResponse));
            response.flushBuffer();
        } catch (IOException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }
}
