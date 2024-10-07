package com.example.cinequest.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EnumException {
    SUCCESS(1, 200, "Success."), INVALID_SERVICE(2, 501, "Invalid service: this service does not exist."),
    AUTHENTICATION_FAILURE(3, 401, "Authentication failed: You do not have access to the service."),
    INVALID_FORMAT(4, 405, "Invalid format: This service does not exist in that format."),
    INVALID_PARAMETER(5, 422, "Invalid parameter: Your request parameters are incorrect."),
    INVALID_ID(6, 404, "Invalid ID: The prerequisite ID is invalid or not found."),
    INVALID_API_KEY(7, 401, "Invalid API key: You must be granted a valid key."),
    DUPLICATE_ENTRY(8, 403, "Duplicate entry: The data you are trying to submit already exists."),
    SERVICE_OFFLINE(9, 503, "Service offline: This service is temporarily offline, please try again later."),
    API_KEY_SUSPENDED(10, 401, "API key suspended: Your access has been suspended, contact TMDB."),
    INTERNAL_ERROR(11, 500, "Internal error: An error occurred, please contact TMDB."),
    RECORD_UPDATED_SUCCESS(12, 201, "Record successfully updated."),
    RECORD_DELETED_SUCCESS(13, 200, "Record successfully deleted."), AUTH_FAILURE(14, 401, "Authentication failure."),
    FAILURE(15, 500, "Failure."), DEVICE_REJECTED(16, 401, "Device denied."),
    SESSION_REJECTED(17, 401, "Session denied."), AUTHENTICATION_FAILED(18, 400, "Authentication failed."),
    INVALID_ACCEPT_HEADER(19, 406, "Invalid accept header."),
    INVALID_DATE_RANGE(20, 422, "Invalid date range: The date range cannot be greater than 14 days."),
    ENTRY_NOT_FOUND(21, 200, "Entry not found: The item you are trying to edit was not found."),
    INVALID_PAGE(22, 400, "Invalid page: Pages start at 1 and go up to 500. They must be integers."),
    INVALID_DATE(23, 400, "Invalid date: The format must be YYYY-MM-DD."),
    GATEWAY_TIMEOUT(24, 504, "Your request to the backend server timed out. Please try again."),
    REQUEST_LIMIT_EXCEEDED(25, 429, "Your request count (#) exceeds the limit allowed (40)."),
    USERNAME_PASSWORD_REQUIRED(26, 400, "You must provide a username and password."),
    TOO_MANY_OBJECTS(27, 400, "Too many objects included in response: The maximum number of remote calls is 20."),
    INVALID_TIMEZONE(28, 400, "Invalid timezone: Please refer to the documentation for valid timezones."),
    CONFIRMATION_REQUIRED(29, 400, "You must confirm this action: Please provide parameter confirm=true."),
    INVALID_CREDENTIALS(30, 401, "Invalid username and/or password: You did not provide valid credentials."),
    ACCOUNT_DISABLED(31, 401, "Account disabled: Your account is no longer active. Contact TMDB if this is a mistake."),
    EMAIL_NOT_VERIFIED(32, 401, "Email not verified: Your email address has not been verified."),
    INVALID_REQUEST_TOKEN(33, 401, "Invalid request token: The request token has expired or is invalid."),
    RESOURCE_NOT_FOUND(34, 404, "The resource you requested could not be found."),
    INVALID_TOKEN(35, 401, "Invalid token."),
    NO_WRITE_PERMISSION(36, 401, "User has not been granted write access for this token."),
    SESSION_NOT_FOUND(37, 404, "The requested session was not found."),
    NO_EDIT_PERMISSION(38, 401, "You do not have permission to edit this resource."),
    RESOURCE_PRIVATE(39, 401, "This resource is private."), NOTHING_TO_UPDATE(40, 200, "Nothing to update."),
    REQUEST_TOKEN_NOT_APPROVED(41, 422, "This request token has not been approved by the user."),
    METHOD_NOT_SUPPORTED(42, 405, "This request method is not supported for this resource."),
    BACKEND_SERVER_UNREACHABLE(43, 502, "Unable to connect to the backend server."),
    INVALID_ID_ERROR(44, 500, "Invalid ID."), USER_SUSPENDED(45, 403, "This user has been suspended."),
    API_UNDER_MAINTENANCE(46, 503, "API is under maintenance. Please try again later."),
    INVALID_INPUT(47, 400, "Invalid input.");

    private final int statusCode;
    private final int httpStatusCode;
    private final String statusMessage;
}
