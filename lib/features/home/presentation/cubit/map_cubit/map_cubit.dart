import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_state.dart';
import 'package:permission_handler/permission_handler.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState());
  double zoom = 18;
  StreamSubscription<Position>? _positionStream;
  GoogleMapController? mapController;

  Future<void> init(BuildContext context) async {
    await _loadMapStyle();
    await _requestPermission();
  }

  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString(AssetsData.mapStyle);
    emit(state.copyWith(mapStyle: style));
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      emit(state.copyWith(permissionGranted: true));
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    final location = LatLng(position.latitude, position.longitude);
    emit(state.copyWith(currentLocation: location, isLoading: false));

    _moveCamera(location);
    _startTracking();
  }

  void _startTracking() {
    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        ).listen((position) {
          final location = LatLng(position.latitude, position.longitude);
          emit(state.copyWith(currentLocation: location));
          _moveCamera(location);
        });
  }

  void setController(GoogleMapController controller) {
    mapController = controller;
    //_addMarkers();
  }

  void _moveCamera(LatLng target) async {
    zoom = await mapController?.getZoomLevel() ?? zoom;
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
    );
    //mapController?.animateCamera(CameraUpdate.zoomTo(zoom));
  }

  // Future<void> _addMarkers() async {
  //   final marker1 = Marker(
  //     markerId: const MarkerId('marker1'),
  //     position: const LatLng(31.23205, 29.95826),
  //     infoWindow: const InfoWindow(title: 'Market 1'),
  //   );

  //   emit(state.copyWith(markers: {marker1}));
  // }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}
