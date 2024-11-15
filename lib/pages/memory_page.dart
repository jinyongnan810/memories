import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/dialogs/delete_memory_dialog.dart';
import 'package:memories/components/helper/duration_helper.dart';
import 'package:memories/components/user_icon.dart';
import 'package:memories/models/memory.dart';
import 'package:memories/providers/memories.dart';
import 'package:memories/quill_embed_builder/image_caption_embed_builder.dart';
import 'package:memories/quill_embed_builder/image_embed_builder.dart';

import '../providers/providers.dart';

class MemoryPage extends HookConsumerWidget {
  const MemoryPage({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(
      () => QuillController(
        readOnly: true,
        document: Document(),
        selection: const TextSelection.collapsed(offset: 0),
      ),
    );
    useEffect(
      () {
        if (id == null || id!.isEmpty) {
          Navigator.of(context).pop();
        }
        return controller.dispose;
      },
      [],
    );
    final focusNode = useFocusNode();
    final memory = useState<Memory?>(null);
    final hasError = useState<bool>(false);
    ref.listen(fetchMemoryProvider(id: id!), (prev, next) {
      if (next is AsyncError) {
        hasError.value = true;
        return;
      }
      final data = next.valueOrNull;
      if (data != null) {
        final json = jsonDecode(data.contents) as List;
        controller.document = Document.fromJson(json);
        memory.value = next.valueOrNull;
        focusNode.requestFocus();
      }
    });
    if (hasError.value) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('取得エラー'),
        ),
        body: const Center(
          child: Text('この思い出にアクセスできませんでした。'),
        ),
      );
    }

    if (memory.value == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('取得中…'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final duration = durationString(memory.value!.startAt, memory.value!.endAt);
    final isMe = ref.watch(loginStatusProvider).userId == memory.value!.userId;

    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: '($duration)${memory.value!.title}',
          child: Text(memory.value!.title, overflow: TextOverflow.ellipsis),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: (isMe
                ? ([
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        ref.invalidate(fetchMemoryProvider(id: id!));
                        GoRouter.of(context)
                            .go('/memories/${memory.value!.id}/edit');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final confirm = await showDeleteDialog(context);
                        if (confirm == true) {}
                        await ref
                            .read(memoriesProvider.notifier)
                            .deleteMemory(memory.value!.id);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ])
                : [
                    const Text('By:'),
                    const SizedBox(width: 4),
                    UserIcon(userId: memory.value!.userId),
                    const SizedBox(width: 12),
                  ]),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: QuillEditor.basic(
          focusNode: focusNode,
          configurations: QuillEditorConfigurations(
            showCursor: false,
            controller: controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ja', 'JP'),
            ),
            embedBuilders: const [
              ImageEmbedBuilder(),
              ImageCaptionEmbedBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
