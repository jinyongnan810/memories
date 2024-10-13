import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/edit_memory_page_common_part.dart';
import 'package:memories/providers/memories.dart';

import '../providers/providers.dart';

class EditMemoryPage extends HookConsumerWidget {
  const EditMemoryPage({super.key, required this.id});
  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          if (id == null || id!.isEmpty) {
            Navigator.of(context).pop();
            return;
          }
        });

        return null;
      },
      [],
    );
    if (id != null) {
      ref.listen(fetchMemoryProvider(id: id!), (prev, next) {
        if (next is AsyncData) {
          final data = next.value;
          if (data == null) {
            Navigator.of(context).pop();
            return;
          }
        }
      });
    }

    return EditMemoryPageCommonPart(
      id: id,
      geoPoint: const GeoPoint(0, 0),
    );
  }
}
