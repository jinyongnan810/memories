import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/edit_memory_page_common_part.dart';

import '../providers/providers.dart';

class AddMemoryPage extends HookConsumerWidget {
  const AddMemoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = useState<GeoPoint?>(null);
    useEffect(
      () {
        Future(() {
          if (!context.mounted) {
            return;
          }
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
    if (location.value == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return EditMemoryPageCommonPart(
      geoPoint: location.value!,
    );
  }
}
