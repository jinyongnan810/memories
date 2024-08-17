import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memories/providers/auth_providers.dart';

Future<void> showAccountSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    constraints: const BoxConstraints(
      maxWidth: 400,
    ),
    builder: (context) {
      return const _Sheet();
    },
  );
}

class _Sheet extends ConsumerWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('ログアウト'),
              onTap: () {
                ref.read(loginStatusProvider.notifier).logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
