import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:memories/components/dialogs/image_detail_dialog.dart';
import 'package:memories/helper/size_helper.dart';

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
    final image = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: () {
              showImageDetailDialog(context, src);
            },
            child: Image.network(src),
          ),
        ),
      ),
    );
    return SizeHelper.isSmallDevice(context)
        ? ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
              minHeight: 50,
              minWidth: 50,
            ),
            child: image,
          )
        : image;
  }
}
