import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:memories/components/dialogs/image_detail_dialog.dart';

class ImageEmbedBuilder extends EmbedBuilder {
  const ImageEmbedBuilder();
  // TODO(kin): 画像と文字のセットで埋め込めるようにする
  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final src = node.value.data as String?;
    if (src == null) {
      return const SizedBox();
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: () {
              showImageDetailDialog(context, src);
            },
            child: CachedNetworkImage(
              imageUrl: src,
              width: 600,
              placeholder: (_, __) {
                return const AspectRatio(
                  aspectRatio: 1.78,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
