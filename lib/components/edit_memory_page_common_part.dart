import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memories/components/dialogs/image_title_input_dialog.dart';
import 'package:memories/providers/auth_providers.dart';
import 'package:memories/providers/logger_providers.dart';
import 'package:memories/providers/memories.dart';
import 'package:memories/quill_embed_builder/image_caption_embed_builder.dart';
import 'package:memories/quill_embed_builder/image_embed_builder.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class EditMemoryPageCommonPart extends HookConsumerWidget {
  const EditMemoryPageCommonPart({
    super.key,
    this.id,
    required this.geoPoint,
  });

  final String? id;
  final GeoPoint geoPoint;

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReadyToEdit = useState(id == null);
    final isSaving = useState(false);
    final location = useState<GeoPoint>(geoPoint);
    final startDateTime = useState<DateTime?>(null);
    final endDateTime = useState<DateTime?>(null);
    final title = useState<String>('');
    final titleTextEditingController =
        useTextEditingController(text: title.value);
    final titleFocusNode = useFocusNode();
    final contentsFocusNode = useFocusNode();
    final controller = useMemoized(
      () => QuillController.basic(editorFocusNode: contentsFocusNode),
    );
    if (id != null) {
      ref.listen(fetchMemoryProvider(id: id!), (prev, next) {
        final data = next.valueOrNull;
        if (data != null) {
          title.value = data.title;
          titleTextEditingController.text = data.title;
          location.value = data.location;
          startDateTime.value = data.startAt;
          endDateTime.value = data.endAt;
          final json = jsonDecode(data.contents) as List;
          controller.document = Document.fromJson(json);
          contentsFocusNode.requestFocus();
          isReadyToEdit.value = true;
        }
      });
    }

    // ignore: always_declare_return_types
    pickDuration() async {
      final dateTimeList = await showOmniDateTimeRangePicker(
        context: context,
        startInitialDate:
            startDateTime.value == null ? DateTime.now() : startDateTime.value!,
        endInitialDate:
            endDateTime.value == null ? DateTime.now() : endDateTime.value!,
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
    }

    useEffect(
      () {
        if (id == null) {
          Future(titleFocusNode.requestFocus);
        }
        return controller.dispose;
      },
      [],
    );

    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: titleTextEditingController,
                focusNode: titleFocusNode,
                decoration: const InputDecoration(hintText: '思い出のタイトル'),
                onChanged: (value) => title.value = value,
              ),
              actions: [
                Tooltip(
                  message: '思い出の期間を選択',
                  child: IconButton(
                    onPressed: pickDuration,
                    icon: startDateTime.value != null
                        ? const Icon(Icons.event_available)
                        : const Icon(Icons.event_busy),
                  ),
                ),
                Tooltip(
                  message: '思い出を保存',
                  child: IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () async {
                      if (title.value.isEmpty) {
                        showSnackbar(context, 'タイトルが入力されていません。');
                        titleFocusNode.requestFocus();
                        return;
                      }
                      if (startDateTime.value == null ||
                          endDateTime.value == null) {
                        showSnackbar(context, '思い出の期間が設定されていません。');
                        await pickDuration();
                        return;
                      }
                      if (controller.document.isEmpty()) {
                        showSnackbar(context, '思い出の詳細が入力されていません。');
                        contentsFocusNode.requestFocus();
                        return;
                      }
                      if (isSaving.value) {
                        return;
                      }
                      isSaving.value = true;
                      if (id == null) {
                        final addedId =
                            await ref.read(memoriesProvider.notifier).addMemory(
                                  title: title.value,
                                  contents: jsonEncode(
                                    controller.document.toDelta().toJson(),
                                  ),
                                  location: location.value,
                                  startAt: startDateTime.value!,
                                  endAt: endDateTime.value!,
                                );
                        if (context.mounted) {
                          if (addedId == null) {
                            showSnackbar(context, '思い出の追加に失敗しました。');
                          } else {
                            showSnackbar(context, '思い出を追加しました！');
                            GoRouter.of(context).go('/memories/$addedId');
                            return;
                          }
                        }
                      } else {
                        await ref.read(memoriesProvider.notifier).updateMemory(
                              id: id!,
                              title: title.value,
                              contents: jsonEncode(
                                controller.document.toDelta().toJson(),
                              ),
                              location: location.value,
                              startAt: startDateTime.value!,
                              endAt: endDateTime.value!,
                            );
                        if (context.mounted) {
                          GoRouter.of(context).go('/');
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: _ContentsEditor(controller: controller),
            ),
          ),
        ),
        if (isSaving.value || !isReadyToEdit.value)
          ColoredBox(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}

class _ContentsEditor extends StatefulHookConsumerWidget {
  const _ContentsEditor({required this.controller});
  final QuillController controller;

  @override
  ConsumerState<_ContentsEditor> createState() => _ContentsEditorState();
}

class _ContentsEditorState extends ConsumerState<_ContentsEditor> {
  Future<void> _pickImageAndUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final userId = ref.read(loginStatusProvider).userId;

    if (pickedFile != null && userId != null) {
      try {
        final fileName =
            'images/$userId/${DateTime.now().millisecondsSinceEpoch}.png';
        final ref = FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = () async {
          if (kIsWeb) {
            return ref.putData(await pickedFile.readAsBytes());
          }
          return ref.putFile(File(pickedFile.path));
        }();
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Update QuillController with the image
        final index = widget.controller.selection.baseOffset;
        final length = widget.controller.selection.extentOffset - index;
        widget.controller.replaceText(
          index,
          length,
          BlockEmbed.image(downloadUrl),
          TextSelection.collapsed(offset: index + 1),
        );
        await _setImageTitle();
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        ref.read(loggerProvider).e('Error uploading image: $e');
      }
    }
  }

  Future<void> _setImageTitle() async {
    final result = await showImageTitleInputDialog(context);
    if (result == null || result.isEmpty) {
      return;
    }
    final index = widget.controller.selection.baseOffset;
    final length = widget.controller.selection.extentOffset - index;
    widget.controller.replaceText(
      index,
      length,
      BlockEmbed.formula(result),
      TextSelection.collapsed(offset: index + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillSimpleToolbar(
          configurations: QuillSimpleToolbarConfigurations(
            controller: widget.controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ja', 'JP'),
            ),
            customButtons: [
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.photo),
                tooltip: '画像を添付する',
                onPressed: _pickImageAndUpload,
              ),
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.closed_caption),
                tooltip: '画像の説明を追加する',
                onPressed: _setImageTitle,
              ),
            ],
            showFontFamily: false,
            showBackgroundColorButton: false,
            showSubscript: false,
            showSuperscript: false,
            showInlineCode: false,
            showItalicButton: false,
            showUnderLineButton: false,
            showCodeBlock: false,
            showDividers: false,
            showClipboardCopy: false,
            showIndent: false,
            showQuote: false,
            showListBullets: false,
            showClearFormat: false,
            showClipboardCut: false,
            showClipboardPaste: false,
            showSearchButton: false,
            showStrikeThrough: false,
            showFontSize: false,
            // multiRowsDisplay: false,
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarBaseButtonOptions(
                afterButtonPressed:
                    widget.controller.editorFocusNode?.requestFocus,
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
        const SizedBox(height: 48),
        Expanded(
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              placeholder: 'どんな思い出でしたか？',
              controller: widget.controller,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('ja', 'JP'),
              ),
              embedBuilders: const [
                ImageEmbedBuilder(),
                ImageCaptionEmbedBuilder(),
              ],
            ),
            focusNode: widget.controller.editorFocusNode,
          ),
        ),
      ],
    );
  }
}
