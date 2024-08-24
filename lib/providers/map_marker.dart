// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/models/map_marker_status.dart';
import 'package:memories/providers/memories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'providers.dart';

part 'map_marker.g.dart';

@riverpod
class MapMarker extends _$MapMarker {
  @override
  MapMarkerStatus build() {
    ref
      ..listen(markerIconProvider, (prev, next) {
        if (prev != next && next.asData?.value != null) {
          state = state.copyWith(
            readyToShowMarkers: true,
            markerIcon: next.asData!.value.normal,
            selectedMarkerIcon: next.asData!.value.selected,
            othersMarkerIcon: next.asData!.value.others,
          );
        }
      })
      ..listen(memoriesProvider, (prev, next) {
        final myUserId = ref.read(loginStatusProvider).userId;
        final markers = next.valueOrNull
            ?.map(
              (e) => Marker(
                markerId: MarkerId(e.id),
                position: LatLng(e.location.latitude, e.location.longitude),
                icon: (e.userId == myUserId
                        ? state.markerIcon
                        : state.othersMarkerIcon) ??
                    BitmapDescriptor.defaultMarker,
                onTap: () {
                  state = state.copyWith(selectedLocation: e.location);
                },
              ),
            )
            .toSet();
        state = state.copyWith(markers: markers ?? {});
      })
      ..listen(loginStatusProvider.select((v) => v.userId), (prev, next) {
        if (prev != next) {
          final memories = ref.read(memoriesProvider).valueOrNull;
          final markers = memories
              ?.map(
                (e) => Marker(
                  markerId: MarkerId(e.id),
                  position: LatLng(e.location.latitude, e.location.longitude),
                  icon: (e.userId == next
                          ? state.markerIcon
                          : state.othersMarkerIcon) ??
                      BitmapDescriptor.defaultMarker,
                  onTap: () {
                    state = state.copyWith(selectedLocation: e.location);
                  },
                ),
              )
              .toSet();
          state = state.copyWith(markers: markers ?? {});
        }
      });
    return const MapMarkerStatus();
  }

  void clearSelectedLocation() {
    state = state.copyWith(selectedLocation: null);
  }

  void setSelectedLocation(GeoPoint location) {
    state = state.copyWith(selectedLocation: location);
  }
}
