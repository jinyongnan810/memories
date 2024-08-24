import 'package:flutter/material.dart';

Future<void> showImageDetailDialog(BuildContext context, String url) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return ImageDetailDialog(url: url);
    },
  );
}

class ImageDetailDialog extends StatelessWidget {
  const ImageDetailDialog({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: InteractiveViewer(
          maxScale: 10,
          minScale: 0.1,
          child: Image.network(url),
        ),
      ),
    );
  }
}
