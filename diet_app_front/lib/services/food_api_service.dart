import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';

class FoodApiService {
  // ※ Androidエミュレータからの接続は 10.0.2.2、実機テストはPCのIPアドレスを指定
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1/foods/search';

  static Future<List<FoodItem>> searchFoods(String query) async {
    final url = Uri.parse('$baseUrl?query=${Uri.encodeComponent(query)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => FoodItem.fromJson(item)).toList();
    } else {
      throw Exception('食品データの取得に失敗しました');
    }
  }
}
