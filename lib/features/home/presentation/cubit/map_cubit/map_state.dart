import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool permissionGranted;
  final LatLng? currentLocation;
  final Set<Marker> markers;
  final String mapStyle;
  final bool isLoading;

  const MapState({
    this.permissionGranted = false,
    this.currentLocation,
    this.markers = const {},
    this.mapStyle = '',
    this.isLoading = true,
  });

  MapState copyWith({
    bool? permissionGranted,
    LatLng? currentLocation,
    Set<Marker>? markers,
    String? mapStyle,
    bool? isLoading,
  }) {
    return MapState(
      permissionGranted: permissionGranted ?? this.permissionGranted,
      currentLocation: currentLocation ?? this.currentLocation,
      markers: markers ?? this.markers,
      mapStyle: mapStyle ?? this.mapStyle,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
