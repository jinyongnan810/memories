import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
        if (ref.read(loginStatusProvider).userId == null) {
          return;
        }
        GoRouter.of(context)
            .go('/add', extra: GeoPoint(latLng.latitude, latLng.longitude));
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
