package com.example.cinequest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cinequest.entity.Movie;

@Repository
public interface FavoriteMovieRepository extends JpaRepository<Movie, Long> {
}
