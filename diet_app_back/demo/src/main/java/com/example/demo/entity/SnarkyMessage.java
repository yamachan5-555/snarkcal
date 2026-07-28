package com.example.demo.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "snarky_messages")
public class SnarkyMessage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nutrient_type", nullable = false, length = 20)
    private String nutrientType; // CALORIE, PROTEIN, FAT, CARB

    @Column(name = "status_type", nullable = false, length = 10)
    private String statusType; // DEFICIT, SURPLUS

    @Column(name = "message_text", nullable = false, length = 255)
    private String messageText;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    // Default Constructor
    public SnarkyMessage() {}

    // Getters
    public Long getId() { return id; }
    public String getNutrientType() { return nutrientType; }
    public String getStatusType() { return statusType; }
    public String getMessageText() { return messageText; }
    public LocalDateTime getCreatedAt() { return createdAt; }

    // Setters
    public void setId(Long id) { this.id = id; }
    public void setNutrientType(String nutrientType) { this.nutrientType = nutrientType; }
    public void setStatusType(String statusType) { this.statusType = statusType; }
    public void setMessageText(String messageText) { this.messageText = messageText; }
}