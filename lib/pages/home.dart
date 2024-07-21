import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatelessWidget {
  Home({super.key});
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.652832, 139.839478),
    zoom: 8,
  );
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Memories'),
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
