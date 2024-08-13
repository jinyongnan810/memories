import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:memories/providers/memories.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../providers/providers.dart';

final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');

class AddMemoryPage extends HookConsumerWidget {
  const AddMemoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = useState<GeoPoint>(const GeoPoint(0, 0));
    final startDateTime = useState<DateTime?>(null);
    final endDateTime = useState<DateTime?>(null);
    final titile = useState<String>('');
    final contents = useState<String>('');
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PickDateArea(
                  startDateTime: startDateTime,
                  endDateTime: endDateTime,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PickDateArea extends StatelessWidget {
  const _PickDateArea({required this.startDateTime, required this.endDateTime});
  final ValueNotifier<DateTime?> startDateTime;
  final ValueNotifier<DateTime?> endDateTime;
  @override
  Widget build(BuildContext context) {
    final start = startDateTime.value;
    final end = endDateTime.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final dateTimeList = await showOmniDateTimeRangePicker(
              context: context,
              barrierDismissible: true,
              constraints: const BoxConstraints(maxWidth: 400),
              startWidget: const Text('開始日時'),
              endWidget: const Text('終了日時'),
              isForceEndDateAfterStartDate: true,
              onStartDateAfterEndDateError: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('開始日時は終了日時より前に設定してください。'),
                  ),
                );
              },
            );
            if (dateTimeList != null) {
              startDateTime.value = dateTimeList[0];
              endDateTime.value = dateTimeList[1];
            }
          },
          label: const Text('思い出の期間を選択'),
          icon: const Icon(Icons.calendar_today),
        ),
        if (start != null && end != null) ...[
          const SizedBox(height: 8),
          Text(
            '${formatter.format(start)} ~ ${formatter.format(end)}',
          ),
        ],
      ],
    );
  }
}
