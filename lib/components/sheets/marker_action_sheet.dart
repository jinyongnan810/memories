import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/helper/durationHelper.dart';
import 'package:memories/providers/memories.dart';

import '../../providers/providers.dart';

class MarkerActionSheet extends HookConsumerWidget {
  const MarkerActionSheet({super.key, required this.location});
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
        memories.valueOrNull?.where((e) => e.location == location).toList() ??
            [];
    final sortedSameLocationMemories = sameLocationMemories
      ..sort((a, b) => a.startAt.compareTo(b.startAt));

    final sheet = DraggableScrollableSheet(
      controller: draggableScrollableController,
      minChildSize: 0,
      initialChildSize: 0.3,
      snapSizes: const [0, 0.3, 1],
      snap: true,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              color: Colors.black,
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                ),
                left: BorderSide(
                  color: Colors.white,
                ),
                right: BorderSide(
                  color: Colors.white,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.white,
                ),
              ],
            ),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: _Handle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SingleChildScrollView(
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
                            ref
                                .read(mapMarkerProvider.notifier)
                                .clearSelectedLocation();

                            goRouter.go(
                              '/add',
                              extra: location,
                            );
                          },
                        ),
                        ...[
                          if (sortedSameLocationMemories.isNotEmpty)
                            for (final memory in sameLocationMemories) ...[
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.star),
                                title: Text(memory.title),
                                subtitle: Text(
                                  durationString(memory.startAt, memory.endAt),
                                ),
                                onTap: () {
                                  // TODO(kin): ここで思い出の詳細画面に遷移する
                                  // GoRouter.of(context).go('/memories/${memory.id}');
                                },
                              ),
                            ],
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return SafeArea(
      child: sheet,
    );
  }
}

class _Handle extends StatelessWidget {
  const _Handle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
