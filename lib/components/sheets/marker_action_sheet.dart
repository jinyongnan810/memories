import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/helper/durationHelper.dart';
import 'package:memories/providers/memories.dart';

import '../../providers/providers.dart';

Future<void> showMarkerActionSheet(
  BuildContext context, {
  required GeoPoint location,
}) async {
  await showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    constraints: const BoxConstraints(
      maxWidth: 400,
    ),
    builder: (context) {
      return _Sheet(location: location);
    },
  );
}

class _Sheet extends HookConsumerWidget {
  const _Sheet({required this.location});
  final GeoPoint location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draggableScrollableController =
        useMemoized(DraggableScrollableController.new);
    useEffect(
      () {
        draggableScrollableController.addListener(() {
          if (draggableScrollableController.pixels <= 10) {
            Navigator.of(context).pop();
          }
        });
        return draggableScrollableController.dispose;
      },
      [],
    );
    final isSignedIn = ref.watch(loginStatusProvider).userId != null;
    final memories = ref.watch(memoriesProvider);
    final sameLocationMemories =
        memories.valueOrNull?.where((e) => e.location == location);
    final sheet = DraggableScrollableSheet(
      controller: draggableScrollableController,
      minChildSize: 0,
      snapSizes: const [0, 0.5, 1],
      snap: true,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                leading: const Icon(Icons.edit),
                title: const Text('思い出を追加する'),
                subtitle: isSignedIn ? null : const Text('ログインが必要です'),
                onTap: () {
                  if (ref.read(loginStatusProvider).userId == null) {
                    final loginNotifier =
                        ref.read(loginStatusProvider.notifier);
                    Navigator.of(context).pop();
                    loginNotifier.login();
                    return;
                  }
                  final goRouter = GoRouter.of(context);
                  Navigator.of(context).pop();

                  goRouter.go(
                    '/add',
                    extra: location,
                  );
                },
              ),
              ...[
                if (sameLocationMemories != null &&
                    sameLocationMemories.isNotEmpty)
                  for (final memory in sameLocationMemories)
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: Text(memory.title),
                      subtitle:
                          Text(durationString(memory.startAt, memory.endAt)),
                      onTap: () {
                        // TODO(kin): ここで思い出の詳細画面に遷移する
                        // GoRouter.of(context).go('/memories/${memory.id}');
                      },
                    ),
              ],
            ],
          ),
        );
      },
    );
    return SafeArea(
      child: sheet,
    );
  }
}
