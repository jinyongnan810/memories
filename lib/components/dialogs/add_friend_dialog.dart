import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<String?> showAddFriendDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return const AddFriendDialog();
    },
  );
}

class AddFriendDialog extends HookWidget {
  const AddFriendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final email = useState<String>('');
    final controller = useTextEditingController();
    return AlertDialog(
      title: const Text('友達を追加する'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: '友達のメールアドレス'),
        onChanged: (value) => email.value = value,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        onSubmitted: (v) => Navigator.of(context).pop(email.value),
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
            Navigator.of(context).pop(email.value);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
