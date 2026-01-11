import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';

class MapState {
  final bool permissionGranted;
  final LatLng? currentLocation;
  final Set<Marker> markers;
  final String mapStyle;
  final bool isLoading;
  final MemoryModel? selectedMemory;

  const MapState({
    this.permissionGranted = false,
    this.currentLocation,
    this.markers = const {},
    this.mapStyle = '',
    this.isLoading = true,
    this.selectedMemory,
  });

  MapState copyWith({
    bool? permissionGranted,
    LatLng? currentLocation,
    Set<Marker>? markers,
    String? mapStyle,
    bool? isLoading,
    MemoryModel? selectedMemory,
  }) {
    return MapState(
      permissionGranted: permissionGranted ?? this.permissionGranted,
      currentLocation: currentLocation ?? this.currentLocation,
      markers: markers ?? this.markers,
      mapStyle: mapStyle ?? this.mapStyle,
      isLoading: isLoading ?? this.isLoading,
      selectedMemory: selectedMemory ?? this.selectedMemory,
    );
  }
}
