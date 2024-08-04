import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class MyUserProfile extends ConsumerWidget {
  const MyUserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus = ref.watch(loginStatusProvider);

    if (loginStatus.userId != null) {
      return GestureDetector(
        onDoubleTap: () {
          ref.read(loginStatusProvider.notifier).logout();
        },
        child: CircleAvatar(
          radius: 20,
          child: ClipOval(
            child: Image.network(
              loginStatus.photoUrl ?? '',
            ),
          ),
        ),
      );
    }
    return IconButton(
      onPressed: () async {
        await ref.read(loginStatusProvider.notifier).login();
      },
      icon: const Icon(Icons.person),
    );
  }
}
