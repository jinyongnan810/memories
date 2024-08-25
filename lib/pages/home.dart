import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memories/components/overlays/menu_overlay_wrapper.dart';
import 'package:memories/providers/memories.dart';

import '../components/components.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Portal(
      child: MenuOverlayWrapper(
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('思い出の星空'),
            // backgroundColor: Colors.transparent,
            // elevation: 0,
            actions: const [
              MyUserProfile(),
              SizedBox(
                width: 12,
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(child: MapView()),
              const Positioned.fill(child: _Loading()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Loading extends ConsumerWidget {
  const _Loading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(memoriesProvider).isLoading;
    if (!isLoading) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text(
                  '思い出を読み込んでいます...',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
