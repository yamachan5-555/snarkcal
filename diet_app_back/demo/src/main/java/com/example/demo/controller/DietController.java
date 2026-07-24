package com.example.demo.controller;

import com.example.demo.dto.DietStatusResponse;
import org.springframework.web.bind.annotation.*;

import java.util.Map; // ★ Mapのエラーを解消するために追加！

@RestController
@RequestMapping("/api/v1")
@CrossOrigin // Flutter(Web)からのアクセスを許可
public class DietController {

    // ★ 変数が定義されていないエラーを解消するため、フィールドとして保持
    private int currentProtein = 45;
    private int currentFat = 85;
    private int currentCarbo = 120;

    private int targetProtein = 100;
    private int targetFat = 45;
    private int targetCarbo = 200;

    // ① 既存のGET通信用API（現在の状態を取得）
    @GetMapping("/diet-status")
    public DietStatusResponse getDietStatus() {
        String message = getMessageByStatus();
        return new DietStatusResponse(
            currentProtein, currentFat, currentCarbo,
            targetProtein, targetFat, targetCarbo,
            message
        );
    }

    // ② 今回追加：食品を加算登録するPOST用API
    @PostMapping("/diet-status/add-food")
    public DietStatusResponse addFood(@RequestBody Map<String, Double> request) {
        double p = request.getOrDefault("protein", 0.0);
        double f = request.getOrDefault("fat", 0.0);
        double c = request.getOrDefault("carbo", 0.0);

        // 現在の合計値に加算（四捨五入してintに変換）
        currentProtein += (int) Math.round(p);
        currentFat += (int) Math.round(f);
        currentCarbo += (int) Math.round(c);

        String message = getMessageByStatus();

        return new DietStatusResponse(
            currentProtein, currentFat, currentCarbo,
            targetProtein, targetFat, targetCarbo,
            message
        );
    }

    // キャラクターメッセージの判定ロジック（共通化）
    private String getMessageByStatus() {
        if (currentFat > targetFat) {
            return "JavaのAPIから届いたメッセージ：油のプールにでも飛び込んだのか？脂質オーバーだ！";
        } else if (currentProtein >= targetProtein) {
            return "JavaのAPIから届いたメッセージ：いい筋肉だ！タンパク質目標達成だな！";
        } else {
            return "JavaのAPIから届いたメッセージ：まだまだ目標には遠いぞ。もっと食べろ！";
        }
    }
}