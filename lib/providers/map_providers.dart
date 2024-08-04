import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/gen/assets.gen.dart';

final markerIconProvider = FutureProvider((ref) async {
  return BitmapDescriptor.asset(
    ImageConfiguration.empty,
    Assets.icons.star.keyName,
  );
});
