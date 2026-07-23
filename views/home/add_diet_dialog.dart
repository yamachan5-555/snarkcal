import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/diet_provider.dart';

class AddDietDialog extends ConsumerStatefulWidget {
  const AddDietDialog({super.key});

  @override
  ConsumerState<AddDietDialog> createState() => _AddDietDialogState();
}

class _AddDietDialogState extends ConsumerState<AddDietDialog> {
  final _pController = TextEditingController();
  final _fController = TextEditingController();
  final _cController = TextEditingController();

  @override
  void dispose() {
    _pController.dispose();
    _fController.dispose();
    _cController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('食事の追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _pController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'タンパク質 (P) [g]'),
            ),
            TextField(
              controller: _fController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '脂質 (F) [g]'),
            ),
            TextField(
              controller: _cController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '炭水化物 (C) [g]'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            final p = int.tryParse(_pController.text) ?? 0;
            final f = int.tryParse(_fController.text) ?? 0;
            final c = int.tryParse(_cController.text) ?? 0;

            // プロバイダーのメソッドを呼び出して状態を更新！
            ref.read(dietStatusProvider.notifier).addDiet(p, f, c);

            Navigator.of(context).pop();
          },
          child: const Text('追加'),
        ),
      ],
    );
  }
}
