package com.example.cinequest.exception;

import lombok.*;
import lombok.experimental.FieldDefaults;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CineQuestApiException extends RuntimeException {
    boolean success;
    ApiResponseCode apiResponseCode;
}
