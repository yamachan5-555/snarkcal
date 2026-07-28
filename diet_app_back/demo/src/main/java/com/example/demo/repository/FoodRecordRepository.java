package com.example.demo.repository;

import com.example.demo.entity.FoodRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface FoodRecordRepository extends JpaRepository<FoodRecord, Long> {

    List<FoodRecord> findByUserIdAndRecordDate(Long userId, LocalDate recordDate);

    // 指定日・指定ユーザーの摂取栄養素の合計値を集計
    @Query("SELECT COALESCE(SUM(f.calories), 0) FROM FoodRecord f WHERE f.userId = :userId AND f.recordDate = :date")
    int sumCaloriesByUserIdAndDate(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query("SELECT COALESCE(SUM(f.protein), 0.0) FROM FoodRecord f WHERE f.userId = :userId AND f.recordDate = :date")
    double sumProteinByUserIdAndDate(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query("SELECT COALESCE(SUM(f.fat), 0.0) FROM FoodRecord f WHERE f.userId = :userId AND f.recordDate = :date")
    double sumFatByUserIdAndDate(@Param("userId") Long userId, @Param("date") LocalDate date);

    @Query("SELECT COALESCE(SUM(f.carbo), 0.0) FROM FoodRecord f WHERE f.userId = :userId AND f.recordDate = :date")
    double sumCarboByUserIdAndDate(@Param("userId") Long userId, @Param("date") LocalDate date);
}