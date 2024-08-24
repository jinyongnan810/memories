import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<String?> showImageTitleInputDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return const ImageTitleInputDialog();
    },
  );
}

class ImageTitleInputDialog extends HookWidget {
  const ImageTitleInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final title = useState<String>('');
    final controller = useTextEditingController();
    return AlertDialog(
      title: const Text('画像のタイトルを設定する'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: '画像のタイトル'),
        onChanged: (value) => title.value = value,
        textInputAction: TextInputAction.done,
        onSubmitted: (v) => Navigator.of(context).pop(title.value),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(title.value);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
