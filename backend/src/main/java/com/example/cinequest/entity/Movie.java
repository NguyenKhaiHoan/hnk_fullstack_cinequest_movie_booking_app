// package com.example.cinequest.entity;
//
// import jakarta.persistence.*;
// import lombok.*;
//
// import java.util.List;
//
// @Getter
// @Setter
// @Builder
// @AllArgsConstructor
// @NoArgsConstructor
// @Entity(name = "movie")
// public class Movie {
//    @Id
//    @Column(name = "id")
//    private Long id;
//
//    @Column(name = "adult", nullable = false)
//    private boolean adult;
//
//    @Column(name = "backdrop_path")
//    private String backdropPath;
//
//    @ElementCollection(fetch = FetchType.EAGER)
//    @CollectionTable(name = "movie_genres", joinColumns = @JoinColumn(name = "movie_id"))
//    @Column(name = "genre_id")
//    private List<Integer> genreIds;
//
//    @Column(name = "original_language")
//    private String originalLanguage;
//
//    @Column(name = "original_title")
//    private String originalTitle;
//
//    @Column(name = "overview", columnDefinition = "TEXT")
//    private String overview;
//
//    @Column(name = "popularity")
//    private double popularity;
//
//    @Column(name = "poster_path")
//    private String posterPath;
//
//    @Column(name = "release_date")
//    private String releaseDate;
//
//    @Column(name = "title")
//    private String title;
//
//    @Column(name = "video", nullable = false)
//    private boolean video;
//
//    @Column(name = "vote_average")
//    private double voteAverage;
//
//    @Column(name = "vote_count")
//    private int voteCount;
// }
