import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_state.dart';
import 'package:permission_handler/permission_handler.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState());

  StreamSubscription<Position>? _positionStream;
  GoogleMapController? mapController;

  Future<void> init(BuildContext context) async {
    await _loadMapStyle(context);
    await _requestPermission();
  }

  Future<void> _loadMapStyle(BuildContext context) async {
    final style = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_style.json');
    emit(state.copyWith(mapStyle: style));
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      emit(state.copyWith(permissionGranted: true));
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
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

  void _moveCamera(LatLng target) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: 14)),
    );
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
