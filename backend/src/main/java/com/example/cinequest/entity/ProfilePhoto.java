package com.example.cinequest.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity(name = "profile_photo")
public class ProfilePhoto {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "photo", length = 100000)
    private byte[] photo;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "id")
    private AppUserDetails userDetails;
}
