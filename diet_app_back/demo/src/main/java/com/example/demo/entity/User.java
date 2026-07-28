package com.example.demo.entity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "diet_users")
public class User {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

@Column(nullable = false, length = 50)
private String name;

@Column(name = "target_calories", nullable = false)
private Integer targetCalories;

@Column(name = "target_protein", nullable = false)
private Double targetProtein;

@Column(name = "target_fat", nullable = false)
private Double targetFat;

@Column(name = "target_carbo", nullable = false)
private Double targetCarbo;

@Column(name = "created_at", insertable = false, updatable = false)
private LocalDateTime createdAt;

@Column(name = "updated_at", insertable = false, updatable = false)
private LocalDateTime updatedAt;

public User() {}

// Getters
public Long getId() { return id; }
public String getName() { return name; }
public Integer getTargetCalories() { return targetCalories; }
public Double getTargetProtein() { return targetProtein; }
public Double getTargetFat() { return targetFat; }
public Double getTargetCarbo() { return targetCarbo; }
public LocalDateTime getCreatedAt() { return createdAt; }
public LocalDateTime getUpdatedAt() { return updatedAt; }

// Setters
public void setId(Long id) { this.id = id; }
public void setName(String name) { this.name = name; }
public void setTargetCalories(Integer targetCalories) { this.targetCalories = targetCalories; }
public void setTargetProtein(Double targetProtein) { this.targetProtein = targetProtein; }
public void setTargetFat(Double targetFat) { this.targetFat = targetFat; }
public void setTargetCarbo(Double targetCarbo) { this.targetCarbo = targetCarbo; }
}