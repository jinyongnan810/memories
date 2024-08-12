import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final markerIconProvider = FutureProvider((ref) async {
  const colors = (
    mainColor: Colors.orange,
    secondaryColor: Colors.white,
  );
  const size = 50.0;
  final bytes = await createCustomMarkerIconImage(
    colors: colors,
    size: const Size(size, size),
  );
  return BitmapDescriptor.bytes(
    bytes.buffer.asUint8List(),
    imagePixelRatio: 1,
    width: size,
    height: size,
  );
  // return BitmapDescriptor.asset(
  //   ImageConfiguration.empty,
  //   Assets.icons.star.keyName,
  // );
});

typedef GradientColors = ({
  Color mainColor,
  Color secondaryColor,
});
Future<ByteData> createCustomMarkerIconImage({
  required GradientColors colors,
  required Size size,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  _MarkerPainter(colors: colors).paint(canvas, size);
  final image = await recorder
      .endRecording()
      .toImage(size.width.floor(), size.height.floor());

  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return bytes!;
}

// TODO(kin): 今星が目的地の上に表示されているので、なんとかしたい。
class _MarkerPainter extends CustomPainter {
  _MarkerPainter({required this.colors});

  final GradientColors colors;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = RadialGradient(
      colors: <Color>[colors.mainColor, colors.secondaryColor],
      radius: 0.8,
      // stops: const [0.2, 1.0],
    );

    final paint = Paint()..shader = gradient.createShader(rect);

    final path = _createStarPath(size);

    canvas.drawPath(path, paint);
  }

  Path _createStarPath(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final halfRadius = radius / 2;

    for (var i = 0; i < 10; i++) {
      final angle = (i * 36 / 180) * pi;
      final length = i.isEven ? radius : halfRadius;
      final x = center.dx + length * sin(angle);
      final y = center.dy + length * -cos(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_MarkerPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(_MarkerPainter oldDelegate) => false;
}
