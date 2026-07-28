package com.example.demo.repository;

import com.example.demo.entity.SnarkyMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SnarkyMessageRepository extends JpaRepository<SnarkyMessage, Long> {

    /**
     * 栄養素タイプと過不足ステータスに該当するメッセージリストを取得
     */
    List<SnarkyMessage> findByNutrientTypeAndStatusType(String nutrientType, String statusType);
}