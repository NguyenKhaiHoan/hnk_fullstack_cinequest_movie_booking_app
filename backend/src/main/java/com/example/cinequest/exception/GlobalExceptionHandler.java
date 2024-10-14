package com.example.cinequest.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import com.example.cinequest.dto.repsonse.Response;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(CineQuestApiException.class)
    public ResponseEntity<Response> handleCineQuestApiException(CineQuestApiException exception, WebRequest request) {
        final Response response = new Response();
        response.setStatusCode(exception.getApiResponseCode().getStatusCode());
        response.setStatusMessage(exception.getApiResponseCode().getStatusMessage());
        HttpStatus httpStatus = switch (exception.getApiResponseCode().getHttpStatusCode()) {
            case 200 -> HttpStatus.OK;
            case 201 -> HttpStatus.CREATED;
            case 401 -> HttpStatus.UNAUTHORIZED;
            case 403 -> HttpStatus.FORBIDDEN;
            case 404 -> HttpStatus.NOT_FOUND;
            case 405 -> HttpStatus.METHOD_NOT_ALLOWED;
            case 406 -> HttpStatus.NOT_ACCEPTABLE;
            case 422 -> HttpStatus.UNPROCESSABLE_ENTITY;
            case 429 -> HttpStatus.TOO_MANY_REQUESTS;
            case 500 -> HttpStatus.INTERNAL_SERVER_ERROR;
            case 501 -> HttpStatus.NOT_IMPLEMENTED;
            case 502 -> HttpStatus.BAD_GATEWAY;
            case 503 -> HttpStatus.SERVICE_UNAVAILABLE;
            case 504 -> HttpStatus.GATEWAY_TIMEOUT;
            default -> HttpStatus.BAD_REQUEST;
        };
        return new ResponseEntity<>(response, httpStatus);
    }
}
