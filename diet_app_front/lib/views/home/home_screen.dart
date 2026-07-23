import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/diet_provider.dart';
import '../target/target_setting_screen.dart';
import 'add_diet_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プロバイダーからモックデータを取得
    final dietStatus = ref.watch(dietStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('マッスル＆ドクゼツ'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TargetSettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // キャラクター表示エリア（アイコンと吹き出し）
            const Icon(Icons.adb, size: 100, color: Colors.green),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Text(
                dietStatus.characterMessage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // PFCバランス表示エリア
            const Text(
              '本日のPFC状況',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPfcBar(
              'タンパク質 (P)',
              dietStatus.totalProtein,
              dietStatus.targetProtein,
              Colors.blue,
            ),
            _buildPfcBar(
              '脂質 (F)',
              dietStatus.totalFat,
              dietStatus.targetFat,
              Colors.orange,
            ),
            _buildPfcBar(
              '炭水化物 (C)',
              dietStatus.totalCarbo,
              dietStatus.targetCarbo,
              Colors.green,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddDietDialog(),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  // PFCの進捗を表示する簡易バー表示用ウィジェット
  Widget _buildPfcBar(String label, int current, int target, Color color) {
    double progress = current / target;
    if (progress > 1.0) progress = 1.0; // バーの最大値は100%に制限

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('$current / ${target}g'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: color,
            minHeight: 12,
          ),
        ],
      ),
    );
  }
}
