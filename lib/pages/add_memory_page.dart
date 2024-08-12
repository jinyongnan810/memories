import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/providers/memories.dart';

import '../providers/providers.dart';

class AddMemoryPage extends HookConsumerWidget {
  const AddMemoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = useState<GeoPoint>(const GeoPoint(0, 0));
    useEffect(
      () {
        Future(() {
          if (ref.read(loginStatusProvider).userId == null) {
            Navigator.of(context).pop();
            return;
          }
          if ((GoRouterState.of(context).extra as GeoPoint?) == null) {
            Navigator.of(context).pop();
            return;
          }
          location.value = GoRouterState.of(context).extra! as GeoPoint;
        });

        return null;
      },
      [],
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('思い出を追加'),
          actions: [
            TextButton(
              onPressed: () async {
                await ref.read(memoriesProvider.notifier).add(
                      title: 'title',
                      contents: 'contents',
                      location: location.value,
                      happenedAt: DateTime.now(),
                    );
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('保存'),
            ),
          ],
        ),
        body: const Center(
          child: Text('Add Memory'),
        ),
      ),
    );
  }
}
