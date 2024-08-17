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

### deploy cors policy to storage
```bash
# create cors.json
[
  {
    "origin": [
      "https://memories-f3a84.web.app",
      "https://memories-f3a84.firebaseapp.com",
      "http://localhost:1234"
    ],
    "method": ["GET"],
    "maxAgeSeconds": 3600
  }
]
# run
gsutil cors set cors.json gs://memories-f3a84.appspot.com
# check
gsutil cors get gs://memories-f3a84.appspot.com
```