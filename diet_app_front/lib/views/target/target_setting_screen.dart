import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/diet_provider.dart';

class TargetSettingScreen extends ConsumerStatefulWidget {
  const TargetSettingScreen({super.key});

  @override
  ConsumerState<TargetSettingScreen> createState() =>
      _TargetSettingScreenState();
}

class _TargetSettingScreenState extends ConsumerState<TargetSettingScreen> {
  late TextEditingController _pTargetController;
  late TextEditingController _fTargetController;
  late TextEditingController _cTargetController;

  @override
  void initState() {
    super.initState();
    // 現在設定されている目標値を初期値としてセット
    final currentStatus = ref.read(dietStatusProvider);
    _pTargetController = TextEditingController(
      text: currentStatus.targetProtein.toString(),
    );
    _fTargetController = TextEditingController(
      text: currentStatus.targetFat.toString(),
    );
    _cTargetController = TextEditingController(
      text: currentStatus.targetCarbo.toString(),
    );
  }

  @override
  void dispose() {
    _pTargetController.dispose();
    _fTargetController.dispose();
    _cTargetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('目標PFC設定'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pTargetController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: '目標タンパク質 (P) [g]'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _fTargetController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: '目標脂質 (F) [g]'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cTargetController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(labelText: '目標炭水化物 (C) [g]'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final targetP = int.tryParse(_pTargetController.text) ?? 100;
                final targetF = int.tryParse(_fTargetController.text) ?? 45;
                final targetC = int.tryParse(_cTargetController.text) ?? 200;

                // プロバイダー経由で目標値を更新
                ref
                    .read(dietStatusProvider.notifier)
                    .updateTargets(targetP, targetF, targetC);

                // 保存後、前の画面（ホーム画面）に戻る
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text(
                '設定を保存する',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
