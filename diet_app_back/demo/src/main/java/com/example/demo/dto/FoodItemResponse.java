package com.example.demo.dto;

/**
 * 食品検索結果・食品詳細レスポンス用DTO
 */
public record FoodItemResponse(
    Long id,
    String name,
    int calories,
    double protein,
    double fat,
    double carbo
) {}