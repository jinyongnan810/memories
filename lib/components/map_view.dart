import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/providers.dart';

class MapView extends ConsumerWidget {
  MapView({super.key});
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.6809591, 139.7673068),
    zoom: 8,
  );
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapMarkerStatus = ref.watch(mapMarkerProvider);

    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _initialPosition,
      onMapCreated: _controller.complete,
      onTap: (latLng) {
        ref.read(mapMarkerProvider.notifier).addMarker(latLng);
      },
      // TODO(me): 自分の場所に移動できるようにする
      // myLocationEnabled: true,
      markers: mapMarkerStatus.readyToShowMarkers
          ? {
              ...mapMarkerStatus.markers.asMap().entries.map(
                    (entry) => Marker(
                      markerId: MarkerId(entry.key.toString()),
                      position: entry.value,
                      icon: mapMarkerStatus.markerIcon ??
                          BitmapDescriptor.defaultMarker,
                    ),
                  ),
            }
          : {},
    );
  }
}
