package com.example.demo.controller;

import com.example.demo.dto.DietStatusResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class DietController {

    @GetMapping("/diet-status")
    public DietStatusResponse getDietStatus() {
        // まずは動作確認用に固定のレスポンスデータを返す
        return new DietStatusResponse(
            45, 85, 120,
            100, 45, 200,
            "JavaのAPIから届いたメッセージ：油のプールにでも飛び込んだのか？"
        );
    }
}