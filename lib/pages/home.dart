import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memories/components/map_view.dart';
import 'package:memories/components/my_user_profile.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
        children: [Positioned.fill(child: MapView())],
      ),
    );
  }
}
