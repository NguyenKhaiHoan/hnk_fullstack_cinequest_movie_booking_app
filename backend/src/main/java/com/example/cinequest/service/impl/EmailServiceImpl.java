package com.example.cinequest.service.impl;

import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.service.EmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

@AllArgsConstructor
@Service
public class EmailServiceImpl implements EmailService {
    private JavaMailSender emailSender;
    private TemplateEngine templateEngine;

    @Override
    public void sendVerificationEmail(String to, String subject, String text) throws CineQuestApiException {
        MimeMessage message = emailSender.createMimeMessage();
        MimeMessageHelper helper;

        try {
            helper = new MimeMessageHelper(message, true);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(text, true);
            emailSender.send(message);

        } catch (MessagingException exception) {
            throw new CineQuestApiException(false,
                    ApiResponseCode.EMAIL_SENDING_FAILED);
        }

    }

    @Override
    public void sendVerificationEmailWithHtmlTemplate(String to, String subject, String templateName, Context context)
            throws CineQuestApiException {
        MimeMessage mimeMessage = emailSender.createMimeMessage();
        MimeMessageHelper helper;

        try {
            helper = new MimeMessageHelper(mimeMessage, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            String htmlContent = templateEngine.process(templateName, context);
            helper.setText(htmlContent, true);
            emailSender.send(mimeMessage);
        } catch (MessagingException exception) {
            throw new CineQuestApiException(false,
                    ApiResponseCode.EMAIL_SENDING_FAILED);
        }
    }
}
