package com.example.cinequest.entity;

import java.util.List;
import java.util.Set;

import jakarta.persistence.*;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity(name = "movie")
public class Movie {
    @Id
    @Column(name = "id")
    Long id;

    @Column(name = "adult", nullable = false)
    boolean adult;

    @Column(name = "backdrop_path")
    String backdropPath;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "movie_genres", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "genre_id")
    List<Integer> genreIds;

    @Column(name = "original_language")
    String originalLanguage;

    @Column(name = "original_title")
    String originalTitle;

    @Column(name = "overview", columnDefinition = "TEXT")
    String overview;

    @Column(name = "popularity")
    double popularity;

    @Column(name = "poster_path")
    String posterPath;

    @Column(name = "release_date")
    String releaseDate;

    @Column(name = "title")
    String title;

    @Column(name = "video", nullable = false)
    boolean video;

    @Column(name = "vote_average")
    double voteAverage;

    @Column(name = "vote_count")
    int voteCount;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "movie_users", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "user_id")
    Set<String> userIds;
}
