import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ImageCaptionEmbedBuilder extends EmbedBuilder {
  const ImageCaptionEmbedBuilder();
  @override
  String get key => BlockEmbed.formulaType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final text = node.value.data as String?;
    if (text == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
