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
            child: _Image(src: src),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatefulWidget {
  const _Image({required this.src});
  final String src;

  @override
  State<_Image> createState() => __ImageState();
}

class __ImageState extends State<_Image> {
  bool _isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.src,
      width: 600,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        _isLoaded = frame != null;
        return child;
      },
      loadingBuilder: (context, child, loadingProgress) {
        // print('⭐️ loadingProgress: $loadingProgress');
        if (_isLoaded && loadingProgress == null) {
          return child;
        }
        final progressValue = (loadingProgress != null &&
                loadingProgress.expectedTotalBytes != null)
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null;
        return AspectRatio(
          aspectRatio: 1.78,
          child: Center(
            child: CircularProgressIndicator(
              value: progressValue,
            ),
          ),
        );
      },
    );
  }
}
