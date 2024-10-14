package com.example.cinequest.service;

import org.thymeleaf.context.Context;

public interface EmailService {
    void sendVerificationEmail(String to, String subject, String text);

    void sendVerificationEmailWithHtmlTemplate(String to, String subject, String templateName, Context context);
}
