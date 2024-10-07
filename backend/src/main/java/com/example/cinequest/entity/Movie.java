package com.example.cinequest.entity;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "favorite_movie")
public class Movie {
    @Id
    @JsonProperty("id")
    @Column(name = "id")
    private Long id;

    @JsonProperty("adult")
    @Column(name = "adult", nullable = false)
    private boolean adult;

    @JsonProperty("backdrop_path")
    @Column(name = "backdrop_path")
    private String backdropPath;

    @JsonProperty("genre_ids")
    @CollectionTable(name = "movie_genres", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "genre_id")
    private List<Integer> genreIds;

    @JsonProperty("original_language")
    @Column(name = "original_language")
    private String originalLanguage;

    @JsonProperty("original_title")
    @Column(name = "original_title")
    private String originalTitle;

    @JsonProperty("overview")
    @Column(name = "overview", columnDefinition = "TEXT")
    private String overview;

    @JsonProperty("popularity")
    @Column(name = "popularity")
    private double popularity;

    @JsonProperty("poster_path")
    @Column(name = "poster_path")
    private String posterPath;

    @JsonProperty("release_date")
    @Column(name = "release_date")
    private String releaseDate;

    @JsonProperty("title")
    @Column(name = "title")
    private String title;

    @JsonProperty("video")
    @Column(name = "video", nullable = false)
    private boolean video;

    @JsonProperty("vote_average")
    @Column(name = "vote_average")
    private double voteAverage;

    @JsonProperty("vote_count")
    @Column(name = "vote_count")
    private int voteCount;
}