package com.example.demo.entity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "food_records")
public class FoodRecord {

@Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

@Column(name = "user_id", nullable = false)
private Long userId;

@Column(name = "food_id")
private Long foodId;

@Column(name = "menu_name", nullable = false, length = 100)
private String menuName;

@Column(nullable = false)
private Integer calories;

@Column(nullable = false)
private Double protein;

@Column(nullable = false)
private Double fat;

@Column(nullable = false)
private Double carbo;

@Column(length = 255)
private String memo;

@Column(name = "record_date", nullable = false)
private LocalDate recordDate;

@Column(name = "created_at", insertable = false, updatable = false)
private LocalDateTime createdAt;

public FoodRecord() {}

// Getters
public Long getId() { return id; }
public Long getUserId() { return userId; }
public Long getFoodId() { return foodId; }
public String getMenuName() { return menuName; }
public Integer getCalories() { return calories; }
public Double getProtein() { return protein; }
public Double getFat() { return fat; }
public Double getCarbo() { return carbo; }
public String getMemo() { return memo; }
public LocalDate getRecordDate() { return recordDate; }
public LocalDateTime getCreatedAt() { return createdAt; }

// Setters
public void setId(Long id) { this.id = id; }
public void setUserId(Long userId) { this.userId = userId; }
public void setFoodId(Long foodId) { this.foodId = foodId; }
public void setMenuName(String menuName) { this.menuName = menuName; }
public void setCalories(Integer calories) { this.calories = calories; }
public void setProtein(Double protein) { this.protein = protein; }
public void setFat(Double fat) { this.fat = fat; }
public void setCarbo(Double carbo) { this.carbo = carbo; }
public void setMemo(String memo) { this.memo = memo; }
public void setRecordDate(LocalDate recordDate) { this.recordDate = recordDate; }
}