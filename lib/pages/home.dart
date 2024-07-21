import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/providers.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.6809591, 139.7673068),
    zoom: 8,
  );
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerIcon = ref.watch(markerIconProvider).valueOrNull;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Memories'),
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // TODO: 自分の場所に移動できるようにする
        // myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: const LatLng(35.6809591, 139.7673068),
            // TODO: show loading when markerIcon is null
            icon: markerIcon ?? BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }
}
