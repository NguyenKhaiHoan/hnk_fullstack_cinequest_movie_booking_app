package com.example.cinequest.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ApiResponseCode {
        // Mã mạng
        INTERNAL_ERROR(1, 500, "Internal server error: An error occurred, please try again later."),
        UNAUTHORIZED_ACCESS(2, 401, "Unauthorized access: You do not have permission to perform this action."),
        SERVICE_UNAVAILABLE(3, 503, "Service unavailable: Please try again later."),
        REQUEST_LIMIT_EXCEEDED(4, 429, "Request limit exceeded: You have exceeded the allowed request limit."),
        METHOD_NOT_SUPPORTED(5, 405, "Method not supported: The requested method is not supported for this resource."),
        RESOURCE_NOT_FOUND(6, 404, "The resource you requested could not be found."),

        // Mã chung
        REQUIRED_FIELD(1000, 400, "This field is required."),
        INVALID_FORMAT(1001, 400, "Invalid format: The input format is incorrect."),
        INVALID_PARAMETER(1003, 422, "Invalid parameter: Your request parameters are incorrect."),
        INVALID_PAGE_NUMBER(1004, 400, "Page number must be greater than 0."),

        // Mã xác thực
        INVALID_EMAIL_FORMAT(2001, 400, "Invalid email format: Please provide a valid email address."),
        PASSWORD_TOO_SHORT(2002, 400, "Password must be at least 8 characters long."),
        PASSWORD_MISSING_UPPERCASE(2003, 400, "Password must contain at least 1 uppercase letter."),
        PASSWORD_MISSING_SPECIAL(2004, 400, "Password must contain at least 1 special character."),
        PASSWORD_MISSING_NUMBER(2005, 400, "Password must contain at least 1 number."),
        PASSWORDS_DO_NOT_MATCH(2006, 400, "Passwords do not match: Please ensure both passwords are the same."),
        JWT_TOKEN_EXPIRED(2007, 401, "JWT token expired: Please log in again."),
        INVALID_JWT_TOKEN(2008, 401, "Invalid JWT token: The token provided is invalid."),
        EMAIL_VERIFICATION_CODE_INVALID(2009, 400, "Invalid verification code: The code provided is incorrect."),
        EMAIL_VERIFICATION_CODE_EXPIRED(2010, 400, "Expired verification code: The verification code has expired."),
        ACCOUNT_NOT_VERIFIED(2011, 403, "Account not verified: Please verify your account."),
        ACCOUNT_NOT_REGISTERED(2012, 404,
                        "Account not registered: Please check the email or register for a new account."),
        VERIFY_ACCOUNT_FAIL(2013, 404,
                        "Verification failed: The account may not be registered. Please check and try again."),
        ACCOUNT_ALREADY_VERIFIED(2014, 403, "Account already verified: Please log in to access your account."),
        USER_NOT_FOUND(2015, 404,
                        "User not found: The user does not exist. Please check again or register a new account."),
        VERIFY_ACCOUNT_SUCCESS(2016, 200,
                        "Verification success: Your account has been successfully verified. You can now log in."),
        VERIFICATION_CODE_SENT(2017, 200, "A new verification code has been sent. Please check!"),
        SIGN_UP_SUCCESS(2018, 200,
                        "Sign up successful: Your account has been created. Please check your email to verify your account."),
        EMAIL_ALREADY_REGISTERED(2019, 409,
                        "The email address is already registered. Please log in or use a different email."),
        RESET_PASSWORD_SUCCESS(2020, 200,
                        "Your password has been successfully updated. You can now log in with your new password."),
        EMAIL_SENDING_FAILED(2021, 500, "Failed to send email: An error occurred while sending the email."),
        BAD_CREDENTIALS(2022, 401, "Bad credentials: The username or password you entered is incorrect."),
        ADMIN_ONLY(2023, 403, "Access denied: This functionality is restricted to admins only."),

        // Mã danh sách phim yêu thích
        MOVIE_NOT_FOUND(3001, 404,
                        "Movie not found: The movie you are trying to access does not exist."),
        MOVIE_ALREADY_EXISTS(3002, 409,
                        "Movie already exists: The movie is already in your movies."),
        MOVIE_ADDED_SUCCESS(3003, 201, "Movie added successfully."),
        MOVIE_REMOVED_SUCCESS(3004, 200, "Movie removed successfully."),
        MOVIE_UPDATED_SUCCESS(3005, 200, "Movie updated successfully."),
        FAVORITE_MOVIE_NOT_FOUND(3006, 404,
                "Favorite movie not found: The favorite movie you are trying to access does not exist."),
        FAVORITE_MOVIE_ALREADY_EXISTS(3007, 409,
                "Favorite movie already exists: The movie is already in your favorites."),
        FAVORITE_MOVIE_ADDED_SUCCESS(3008, 201, "Favorite movie added successfully."),
        FAVORITE_MOVIE_REMOVED_SUCCESS(3009, 200, "Favorite movie removed successfully."),
        FAVORITE_MOVIE_UPDATED_SUCCESS(3010, 200, "Favorite movie updated successfully."),

        // Mã xử lý ảnh
        IMAGE_COMPRESSION_ERROR(4001, 500, "Image compression failed: Unable to compress the image."),
        IMAGE_DECOMPRESSION_ERROR(4002, 500, "Image decompression failed: Unable to decompress the image."),

        // Mã cập nhật tài khoản
        ACCOUNT_SETUP_SUCCESS(5001, 200,
                        "Your account setup is complete. You can now fully enjoy our services with your personalized account settings."),
        ACCOUNT_UPDATE_SUCCESS(5002, 200,
                        "Your account details have been successfully updated. The changes are now reflected in your profile.");

        private final int statusCode;
        private final int httpStatusCode;
        private final String statusMessage;
}
