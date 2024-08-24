import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    final selectedLocation = mapMarkerStatus.selectedLocation;
    // TODO(kin): このwidgetを完全にタップできないようにしたい
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _initialPosition,
      onMapCreated: _controller.complete,
      webGestureHandling: mapMarkerStatus.selectedLocation != null
          ? WebGestureHandling.none
          : WebGestureHandling.auto,

      onTap: (latLng) {
        if (mapMarkerStatus.selectedLocation != null) {
          ref.read(mapMarkerProvider.notifier).clearSelectedLocation();
          return;
        }
        ref.read(mapMarkerProvider.notifier).setSelectedLocation(
              GeoPoint(latLng.latitude, latLng.longitude),
            );
      },
      // TODO(me): 自分の場所に移動できるようにする
      // myLocationEnabled: true,
      markers: mapMarkerStatus.readyToShowMarkers
          ? {
              ...mapMarkerStatus.markers,
              if (selectedLocation != null)
                Marker(
                  markerId: const MarkerId('temp'),
                  position: LatLng(
                    selectedLocation.latitude,
                    selectedLocation.longitude,
                  ),
                  icon: mapMarkerStatus.selectedMarkerIcon ??
                      BitmapDescriptor.defaultMarker,
                ),
            }
          : {},
    );
  }
}
