import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 400),
      child: Image.network(src),
    );
  }
}
