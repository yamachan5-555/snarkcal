package com.example.demo.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.time.LocalDate;

public class DailyNutritionResponse {
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;
    private String message;
    
    private int currentCalories;
    private int targetCalories;
    
    private double currentProtein;
    private double targetProtein;
    
    private double currentFat;
    private double targetFat;
    
    private double currentCarbo;
    private double targetCarbo;

    public DailyNutritionResponse() {}

    public DailyNutritionResponse(LocalDate date, String message, 
                                  int currentCalories, int targetCalories, 
                                  double currentProtein, double targetProtein, 
                                  double currentFat, double targetFat, 
                                  double currentCarbo, double targetCarbo) {
        this.date = date;
        this.message = message;
        this.currentCalories = currentCalories;
        this.targetCalories = targetCalories;
        this.currentProtein = currentProtein;
        this.targetProtein = targetProtein;
        this.currentFat = currentFat;
        this.targetFat = targetFat;
        this.currentCarbo = currentCarbo;
        this.targetCarbo = targetCarbo;
    }

    // Getters & Setters
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public int getCurrentCalories() { return currentCalories; }
    public void setCurrentCalories(int currentCalories) { this.currentCalories = currentCalories; }

    public int getTargetCalories() { return targetCalories; }
    public void setTargetCalories(int targetCalories) { this.targetCalories = targetCalories; }

    public double getCurrentProtein() { return currentProtein; }
    public void setCurrentProtein(double currentProtein) { this.currentProtein = currentProtein; }

    public double getTargetProtein() { return targetProtein; }
    public void setTargetProtein(double targetProtein) { this.targetProtein = targetProtein; }

    public double getCurrentFat() { return currentFat; }
    public void setCurrentFat(double currentFat) { this.currentFat = currentFat; }

    public double getTargetFat() { return targetFat; }
    public void setTargetFat(double targetFat) { this.targetFat = targetFat; }

    public double getCurrentCarbo() { return currentCarbo; }
    public void setCurrentCarbo(double currentCarbo) { this.currentCarbo = currentCarbo; }

    public double getTargetCarbo() { return targetCarbo; }
    public void setTargetCarbo(double targetCarbo) { this.targetCarbo = targetCarbo; }
}