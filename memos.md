## Memos
### Render CustomPainter to Image
```dart
import 'dart:typed_data';
import 'dart:ui' as ui;
final recorder = ui.PictureRecorder();
final canvas = Canvas(recorder);
_MarkerPainter(colors: colors).paint(canvas, size);
final image = await recorder
    .endRecording()
    .toImage(size.width.floor(), size.height.floor());

final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
return bytes!;
```