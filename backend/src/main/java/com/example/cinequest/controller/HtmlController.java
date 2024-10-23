package com.example.cinequest.controller;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/html")
public class HtmlController {
    @GetMapping("/reset-password-form")
    public ResponseEntity<Resource> resetPasswordForm() {
        Resource resource = new ClassPathResource("templates/reset-password-page.html");
        return ResponseEntity.ok()
                .contentType(MediaType.TEXT_HTML)
                .body(resource);
    }

    @GetMapping("/verification-email")
    public ResponseEntity<Resource> verificationEmail() {
        Resource resource = new ClassPathResource("templates/verification-email.html");
        return ResponseEntity.ok()
                .contentType(MediaType.TEXT_HTML)
                .body(resource);
    }

    @GetMapping("/reset-password-email")
    public ResponseEntity<Resource> resetPasswordEmail() {
        Resource resource = new ClassPathResource("templates/reset-password-email.html");
        return ResponseEntity.ok()
                .contentType(MediaType.TEXT_HTML)
                .body(resource);
    }

    @GetMapping("/resend-verification-email")
    public ResponseEntity<Resource> resendVerificationEmail() {
        Resource resource = new ClassPathResource("templates/resend-verification-email.html");
        return ResponseEntity.ok()
                .contentType(MediaType.TEXT_HTML)
                .body(resource);
    }
}
