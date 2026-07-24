import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/food_item.dart';
import '../../models/diet_status.dart';
import '../../providers/diet_provider.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodItem> _searchResults = [];
  bool _isLoading = false;

  // Javaの食品検索APIを呼び出すメソッド
  Future<void> _searchFoods(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
      'http://localhost:8080/api/v1/foods/search?query=${Uri.encodeComponent(query)}',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _searchResults = data.map((item) => FoodItem.fromJson(item)).toList();
          _searchResults = data.map((json) => FoodItem.fromJson(json)).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('検索エラー: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('食品・食材検索'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 検索入力欄
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '食品名を入力（例：ささみ、白米）',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchFoods('');
                  },
                ),
              ),
              onChanged: (value) {
                _searchFoods(value);
              },
            ),
            const SizedBox(height: 16),

            // 検索結果の表示エリア
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                  ? const Center(child: Text('該当する食品が見つかりません'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final food = _searchResults[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(
                              food.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${food.calories} kcal | P:${food.protein}g F:${food.fat}g C:${food.carbo}g 塩分:${food.salt}g',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.amber,
                            ),
                            onTap: () {
                              _showAmountDialog(context, food);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAmountDialog(BuildContext context, FoodItem food) {
  final TextEditingController amountController = TextEditingController(
    text: '100',
  ); // デフォルト100g

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('${food.name} の記録'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('食べた量 (g) を入力してください'),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '分量 (g)',
                suffixText: 'g',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () async {
              final double amount =
                  double.tryParse(amountController.text) ?? 100.0;
              final double ratio = amount / 100.0; // 100gあたりの倍率計算

              // 食べた量に応じたPFCを計算
              final double p = food.protein * ratio;
              final double f = food.fat * ratio;
              final double c = food.carbo * ratio;

              // Java APIにPOST送信
              final url = Uri.parse(
                'http://localhost:8080/api/v1/diet-status/add-food',
              );
              try {
                final response = await http.post(
                  url,
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({'protein': p, 'fat': f, 'carbo': c}),
                );

                if (!context.mounted) return;

                if (response.statusCode == 200) {
                  final Map<String, dynamic> responseData = json.decode(
                    utf8.decode(response.bodyBytes),
                  );
                  final updatedStatus = DietStatus.fromJson(responseData);

                  ref
                      .read(dietStatusProvider.notifier)
                      .updateStatus(updatedStatus);

                  // ダイアログ閉じる
                  Navigator.pop(dialogContext);

                  // 検索画面閉じつつ、呼び出し元にtrueを返す
                  Navigator.pop(context, true);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${food.name} (${amount}g) を記録しました！'),
                    ),
                  );
                }
              } catch (e) {
                if (!context.mounted) return;

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('登録エラー: $e')));
              }
            },
            child: const Text('追加する'),
          ),
        ],
      );
    },
  );
}
