import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/data/repo/memories_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoriesRepoImpl implements MemoriesRepo {
  @override
  Future<void> createMemory({
    required List<String> urls,
    required String caption,
    required LatLng position,
    String visibility = "private",
  }) async {
    final supabase = getIt<SupabaseClient>();
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('memories')
        .insert({
          'u_id': userId,
          'caption': caption,
          'lat': position.latitude,
          'lng': position.longitude,
          'created_at': DateTime.now().toIso8601String(),
          'visibility': visibility,
        })
        .select()
        .single();
    await supabase
        .from('photos')
        .insert(
          urls.map((url) {
            return {
              'u_id': userId,
              'image_url': url,
              'created_at': DateTime.now().toIso8601String(),
              'm_id': data['m_id'],
            };
          }).toList(),
        );
  }

  @override
  Future<List<MemoryModel>> getMemories({
    required String userId,
    int range = 100,
    String visibility = "public",
  }) {
    // TODO: implement getMemories
    throw UnimplementedError();
  }
}
