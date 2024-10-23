package com.example.cinequest.entity;

import java.time.LocalDateTime;
import java.util.Set;

import jakarta.persistence.*;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity(name = "user")
public class User {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "verification_code")
    private String verificationCode;

    @Column(name = "verification_expiration")
    private LocalDateTime verificationCodeExpiresAt;

    @Column(name = "enabled")
    private boolean enabled;

    @Column(name = "reset_password_form_id")
    private String resetPasswordFormId;

    @Column(name = "reset_password_form_expiration")
    private LocalDateTime resetPasswordFormExpiresAt;

    @ManyToMany(fetch = FetchType.EAGER)
    Set<Role> roles;

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }
}
