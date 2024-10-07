package com.example.cinequest.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.cinequest.entity.Movie;

public interface FavoriteMovieRepository extends JpaRepository<Movie, Long> {
}
