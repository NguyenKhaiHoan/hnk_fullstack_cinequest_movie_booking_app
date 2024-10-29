package com.example.cinequest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.cinequest.entity.Movie;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {
    @Query("SELECT m FROM movie m JOIN m.userIds u WHERE u = :userId")
    List<Movie> findMoviesByUserId(@Param("userId") String userId);
}
