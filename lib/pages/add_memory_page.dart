import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:memories/providers/memories.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../providers/providers.dart';

final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');

// TODO(kin): この画面をに画面に分離する
class AddMemoryPage extends HookConsumerWidget {
  const AddMemoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = useState<GeoPoint>(const GeoPoint(0, 0));
    final startDateTime = useState<DateTime?>(null);
    final endDateTime = useState<DateTime?>(null);
    final title = useState<String>('');
    final titleFocusNode = useFocusNode();
    final contentsFocusNode = useFocusNode();
    final controller = useMemoized(
      () => QuillController.basic(editorFocusNode: contentsFocusNode),
    );
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
          titleFocusNode.requestFocus();
          location.value = GoRouterState.of(context).extra! as GeoPoint;
        });

        return controller.dispose;
      },
      [],
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            focusNode: titleFocusNode,
            decoration: const InputDecoration(hintText: '思い出のタイトル'),
            onChanged: (value) => title.value = value,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (title.value.isEmpty) {
                  showSnackbar(context, 'タイトルが入力されていません。');
                  titleFocusNode.requestFocus();
                  return;
                }
                if (startDateTime.value == null || endDateTime.value == null) {
                  showSnackbar(context, '思い出の期間が設定されていません。');
                  return;
                }
                if (controller.document.isEmpty()) {
                  showSnackbar(context, '思い出の詳細が入力されていません。');
                  contentsFocusNode.requestFocus();
                  return;
                }
                await ref.read(memoriesProvider.notifier).add(
                      title: title.value,
                      contents:
                          jsonEncode(controller.document.toDelta().toJson()),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PickDateArea(
                startDateTime: startDateTime,
                endDateTime: endDateTime,
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Expanded(child: _Contents(controller: controller)),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
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

class _Contents extends HookWidget {
  const _Contents({required this.controller});
  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillSimpleToolbar(
          configurations: QuillSimpleToolbarConfigurations(
            controller: controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ja', 'JP'),
            ),
            showFontFamily: false,
            showBackgroundColorButton: false,
            showSubscript: false,
            showSuperscript: false,
            showInlineCode: false,
            showItalicButton: false,
            showUnderLineButton: false,
            showCodeBlock: false,
            showDividers: false,
            multiRowsDisplay: false,
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarBaseButtonOptions(
                afterButtonPressed: controller.editorFocusNode?.requestFocus,
              ),
              fontSize: const QuillToolbarFontSizeButtonOptions(
                defaultDisplayText: 'サイズ',
              ),
            ),
            fontSizesValues: const {
              'Small': '12',
              'Medium': '24',
              'Large': '48',
            },
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              placeholder: 'どんな思い出でしたか？',
              controller: controller,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('ja', 'JP'),
              ),
            ),
            focusNode: controller.editorFocusNode,
          ),
        ),
      ],
    );
  }
}
