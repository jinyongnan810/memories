import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memories/components/helper/duration_helper.dart';
import 'package:memories/models/memory.dart';
import 'package:memories/providers/memories.dart';
import 'package:memories/quill_embed_builder/image_caption_embed_builder.dart';
import 'package:memories/quill_embed_builder/image_embed_builder.dart';

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
    ref.listen(fetchMemoryProvider(id: id!), (prev, next) {
      final data = next.valueOrNull;
      if (data != null) {
        final json = jsonDecode(data.contents) as List;
        controller.document = Document.fromJson(json);
        memory.value = next.valueOrNull;
        focusNode.requestFocus();
      }
    });

    if (memory.value == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final duration = durationString(memory.value!.startAt, memory.value!.endAt);

    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          triggerMode: TooltipTriggerMode.tap,
          message: '($duration)${memory.value!.title}',
          child: Text(memory.value!.title, overflow: TextOverflow.ellipsis),
        ),
        centerTitle: true,
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
