import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MemoriesRepo {
  Future<void> createMemory({
    required List<String> urls,
    required String caption,
    required LatLng position,
    String visibility = "private",
  });
}
