import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/helper/duration_helper.dart';
import 'package:memories/components/user_icon.dart';
import 'package:memories/providers/memories.dart';

import '../../providers/providers.dart';

class MarkerActionSheet extends ConsumerStatefulWidget {
  const MarkerActionSheet({super.key, required this.location});
  final GeoPoint location;

  @override
  ConsumerState<MarkerActionSheet> createState() => _MarkerActionSheetState();
}

class _MarkerActionSheetState extends ConsumerState<MarkerActionSheet> {
  late final DraggableScrollableController draggableScrollableController;
  @override
  void initState() {
    super.initState();
    draggableScrollableController = DraggableScrollableController();
    draggableScrollableController.addListener(() {
      if (draggableScrollableController.pixels <= 50) {
        ref.read(mapMarkerProvider.notifier).clearSelectedLocation();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    draggableScrollableController.dispose();
  }

  @override
  void didUpdateWidget(covariant MarkerActionSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    draggableScrollableController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final isSignedIn = ref.watch(loginStatusProvider).userId != null;
    final memories = ref.watch(memoriesProvider);
    final sameLocationMemories = memories.valueOrNull
            ?.where((e) => e.location == widget.location)
            .toList() ??
        [];
    final sortedSameLocationMemories = sameLocationMemories
      ..sort((a, b) => b.startAt.compareTo(a.startAt));

    final sheet = DraggableScrollableSheet(
      controller: draggableScrollableController,
      minChildSize: 0,
      initialChildSize: 0.3,
      snapSizes: const [0, 0.3, 1],
      snap: true,
      expand: false,
      builder: (context, scrollController) {
        return ScrollConfiguration(
          // https://github.com/flutter/flutter/issues/101903#issuecomment-1771507814
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: Material(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
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
                  const Positioned(
                    top: 12,
                    left: 0,
                    right: 0,
                    child: Center(child: _Handle()),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 28),
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
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
                          subtitle:
                              isSignedIn ? null : const Text('(ログインが必要です)'),
                          onTap: () {
                            if (ref.read(loginStatusProvider).userId == null) {
                              ref.read(loginStatusProvider.notifier).login();
                              return;
                            }
                            final goRouter = GoRouter.of(context);
                            ref
                                .read(mapMarkerProvider.notifier)
                                .clearSelectedLocation();

                            goRouter.go(
                              '/add',
                              extra: widget.location,
                            );
                          },
                        ),
                        ...[
                          for (final entry
                              in sortedSameLocationMemories.asMap().entries)
                            ListTile(
                              leading: UserIcon(userId: entry.value.userId),
                              title: Text(entry.value.title),
                              subtitle: Text(
                                durationStringForSheet(
                                  entry.value.startAt,
                                  entry.value.endAt,
                                ),
                              ),
                              onTap: () {
                                ref
                                    .read(mapMarkerProvider.notifier)
                                    .clearSelectedLocation();
                                GoRouter.of(context)
                                    .go('/memories/${entry.value.id}');
                              },
                            ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
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
