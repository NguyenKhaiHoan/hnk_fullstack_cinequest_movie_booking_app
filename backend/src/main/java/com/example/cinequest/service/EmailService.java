package com.example.cinequest.service;

import jakarta.mail.MessagingException;
import org.thymeleaf.context.Context;

public interface EmailService {
    void sendVerificationEmail(String to, String subject, String text) throws MessagingException;

    void sendVerificationEmailWithHtmlTemplate(String to, String subject, String templateName, Context context)
            throws MessagingException;
}
