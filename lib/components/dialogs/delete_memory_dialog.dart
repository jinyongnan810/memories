import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<bool?> showDeleteMemoryDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return const DeleteMemoryDialog();
    },
  );
}

class DeleteMemoryDialog extends HookWidget {
  const DeleteMemoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('本当に削除しますか？'),
      content: const Text('この操作は取り消せません。'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
