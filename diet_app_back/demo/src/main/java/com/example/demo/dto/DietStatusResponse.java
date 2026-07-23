package com.example.demo.dto;

public record DietStatusResponse(
    int totalProtein,
    int totalFat,
    int totalCarbo,
    int targetProtein,
    int targetFat,
    int targetCarbo,
    String characterMessage
) {}