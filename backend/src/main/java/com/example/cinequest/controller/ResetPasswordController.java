package com.example.cinequest.controller;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.service.ResetPasswordService;
import com.example.cinequest.util.ValidateUtil;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("/reset-password")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ResetPasswordController {
    ResetPasswordService resetPasswordService;

    @GetMapping("/{reset_password_form_id}")
    public ResponseEntity<Resource> resetPasswordPage(
            @PathVariable("reset_password_form_id") String resetPasswordFormId) {
        try {
            resetPasswordService.isExpiredFormResetPassword(resetPasswordFormId);
        } catch (CineQuestApiException exception) {
            Resource resource = new ClassPathResource("templates/error-page.html");
            return ResponseEntity.status(404).contentType(MediaType.TEXT_HTML).body(resource);
        }

        Resource resource = new ClassPathResource("templates/reset-password-page.html");
        return ResponseEntity.ok().contentType(MediaType.TEXT_HTML).body(resource);
    }

    @PostMapping("/reset")
    public ResponseEntity<String> handleResetPassword(
            @RequestParam("reset_password_form_id") String resetPasswordFormId,
            @RequestParam("new_password") String newPassword,
            @RequestParam("confirm_password") String confirmPassword) {
        try {
            ValidateUtil.validatePasswordConfirm(newPassword, confirmPassword);
        } catch (CineQuestApiException exception) {
            return ResponseEntity.badRequest()
                    .body(exception.getApiResponseCode().getStatusMessage());
        }

        try {
            resetPasswordService.resetPassword(resetPasswordFormId, newPassword);
        } catch (CineQuestApiException exception) {
            return ResponseEntity.badRequest().body(ApiResponseCode.FORM_RESET_PASSWORD_EXPIRED.getStatusMessage());
        }

        return ResponseEntity.ok("Password has been reset successfully.");
    }
}
