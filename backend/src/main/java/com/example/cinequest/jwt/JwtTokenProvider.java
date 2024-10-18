package com.example.cinequest.jwt;

import java.text.ParseException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.StringJoiner;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import com.example.cinequest.entity.User;
import com.example.cinequest.exception.ApiResponseCode;
import com.example.cinequest.exception.CineQuestApiException;
import com.example.cinequest.repository.UserRepository;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class JwtTokenProvider {
    @Value("${security.jwt.secret-key}")
    String jwtSecretKey;

    @Value("${security.jwt.expiration-time}")
    Long jwtExpirationTime;

    @Value("${security.jwt.refreshable-time}")
    Long jwtRefreshableTime;

    public JwtModel generateToken(User user) {
        try {
            JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);

            JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                    .subject(user.getEmail())
                    .issuer("https://github.com/NguyenKhaiHoan")
                    .issueTime(new Date())
                    .expirationTime(Date.from(Instant.now().plus(jwtExpirationTime, ChronoUnit.HOURS)))
                    .jwtID(UUID.randomUUID().toString())
                    .claim("scope", buildScope(user))
                    .build();

            LocalDateTime tokenExpiresAt = LocalDateTime.from(
                    jwtClaimsSet.getExpirationTime().toInstant().atZone(ZoneId.systemDefault()));

            Payload payload = new Payload(jwtClaimsSet.toJSONObject());

            JWSObject jwsObject = new JWSObject(header, payload);

            jwsObject.sign(new MACSigner(jwtSecretKey.getBytes()));

            return JwtModel.builder()
                    .token(jwsObject.serialize())
                    .tokenExpiresAt(tokenExpiresAt)
                    .build();
        } catch (Exception exception) {
            throw new CineQuestApiException(false, ApiResponseCode.JWT_TOKEN_CREATION_FAILED);
        }
    }

    public SignedJWT verifyToken(String token, boolean isRefresh) {
        try {
            JWSVerifier verifier = new MACVerifier(jwtSecretKey.getBytes());

            SignedJWT signedJWT = SignedJWT.parse(token);

            Date expiryTime = (isRefresh)
                    ? Date.from(signedJWT
                            .getJWTClaimsSet()
                            .getIssueTime()
                            .toInstant()
                            .plus(jwtRefreshableTime, ChronoUnit.HOURS))
                    : signedJWT.getJWTClaimsSet().getExpirationTime();

            boolean verified = signedJWT.verify(verifier);

            if (!verified) {
                throw new CineQuestApiException(false, ApiResponseCode.INVALID_JWT_TOKEN);
            }

            if (!expiryTime.after(new Date())) {
                throw new CineQuestApiException(false, ApiResponseCode.JWT_TOKEN_EXPIRED);
            }

            return signedJWT;
        } catch (JOSEException | ParseException e) {
            throw new CineQuestApiException(false, ApiResponseCode.INTERNAL_ERROR);
        }
    }

    private String buildScope(User user) {
        StringJoiner stringJoiner = new StringJoiner(" ");

        if (!CollectionUtils.isEmpty(user.getRoles())) {
            user.getRoles().forEach(role -> stringJoiner.add("ROLE_" + role.getName()));
        } else {
            log.info("Else");
        }

        return stringJoiner.toString();
    }

    public User validateSelfRequestById(String userId, UserRepository userRepository) {
        return getUser(userId, userRepository);
    }

    private User getUser(String userId, UserRepository userRepository) {
        var context = SecurityContextHolder.getContext();
        String email = context.getAuthentication().getName();

        User user = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new CineQuestApiException(false, ApiResponseCode.ACCOUNT_NOT_REGISTERED));

        if (!user.getId().equals(userId)) {
            throw new CineQuestApiException(false, ApiResponseCode.UNAUTHORIZED_ACCESS);
        }

        return user;
    }

    public User validateSelfRequestByEmail(String userEmail, UserRepository userRepository) {
        return getUser(userEmail, userRepository);
    }
}
