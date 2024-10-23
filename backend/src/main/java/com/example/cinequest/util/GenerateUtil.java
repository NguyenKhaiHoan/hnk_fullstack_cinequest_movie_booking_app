package com.example.cinequest.util;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class GenerateUtil {
    private GenerateUtil() {}

    private static final String UPPER_CASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWER_CASE = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARACTERS = "!@#$%^&*()-_+=<>?";

    private static final SecureRandom secureRandom = new SecureRandom();
    private static final Random random = new Random();

    public static String generateSecureRandomString(int length) {
        List<Character> passwordChars = new ArrayList<>();

        passwordChars.add(UPPER_CASE.charAt(secureRandom.nextInt(UPPER_CASE.length())));
        passwordChars.add(DIGITS.charAt(secureRandom.nextInt(DIGITS.length())));
        passwordChars.add(SPECIAL_CHARACTERS.charAt(secureRandom.nextInt(SPECIAL_CHARACTERS.length())));

        String allAllowedChars = UPPER_CASE + LOWER_CASE + DIGITS + SPECIAL_CHARACTERS;
        for (int i = 3; i < length; i++) {
            passwordChars.add(allAllowedChars.charAt(secureRandom.nextInt(allAllowedChars.length())));
        }

        Collections.shuffle(passwordChars);

        StringBuilder password = new StringBuilder();
        for (char c : passwordChars) {
            password.append(c);
        }

        return password.toString();
    }

    public static String generateVerificationCode() {
        int rValue = random.nextInt(999999);
        return String.format("%06d", rValue);
    }
}
