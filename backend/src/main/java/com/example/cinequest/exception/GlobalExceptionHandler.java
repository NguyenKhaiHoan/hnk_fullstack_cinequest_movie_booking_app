package com.example.cinequest.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import com.example.cinequest.dto.repsonse.Response;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(CinequestApiException.class)
    public ResponseEntity<Response> handleCinequestApiException(CinequestApiException exception, WebRequest request) {
        final Response response = new Response();
        response.setStatusCode(exception.getStatusCode());
        response.setStatusMessage(exception.getStatusMessage());
        HttpStatus httpStatus;
        switch (exception.getHttpStatusCode()) {
            case 200:
                httpStatus = HttpStatus.OK;
                break;
            case 201:
                httpStatus = HttpStatus.CREATED;
                break;
            case 400:
                httpStatus = HttpStatus.BAD_REQUEST;
                break;
            case 401:
                httpStatus = HttpStatus.UNAUTHORIZED;
                break;
            case 403:
                httpStatus = HttpStatus.FORBIDDEN;
                break;
            case 404:
                httpStatus = HttpStatus.NOT_FOUND;
                break;
            case 405:
                httpStatus = HttpStatus.METHOD_NOT_ALLOWED;
                break;
            case 406:
                httpStatus = HttpStatus.NOT_ACCEPTABLE;
                break;
            case 422:
                httpStatus = HttpStatus.UNPROCESSABLE_ENTITY;
                break;
            case 429:
                httpStatus = HttpStatus.TOO_MANY_REQUESTS;
                break;
            case 500:
                httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
                break;
            case 501:
                httpStatus = HttpStatus.NOT_IMPLEMENTED;
                break;
            case 502:
                httpStatus = HttpStatus.BAD_GATEWAY;
                break;
            case 503:
                httpStatus = HttpStatus.SERVICE_UNAVAILABLE;
                break;
            case 504:
                httpStatus = HttpStatus.GATEWAY_TIMEOUT;
                break;
            default:
                httpStatus = HttpStatus.BAD_REQUEST;
                break;
        }
        return new ResponseEntity<>(response, httpStatus);
    }
}
