import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';

abstract class MemoriesRepo {
  Future<void> createMemory({
    required List<String> urls,
    required String caption,
    required LatLng position,
    String visibility = "private",
  });

  Future<List<MemoryModel>> getMemories({
    required String userId,
    int range = 100,
    String visibility = "public",
  });
}
