import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/home/data/repo/memories_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoriesRepoImpl implements MemoriesRepo {
  final SupabaseClient supabase = getIt<SupabaseClient>();

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
    int limit = 20,
    required LatLng position,
  }) async {
    List response;
    if (userId != "") {
      response = await supabase.rpc(
        'get_nearby_memories',
        params: {
          'user_lat': position.latitude,
          'user_lng': position.longitude,
          'radius_meters': 100,
          'limit_count': 20,
          'visibility_filter': visibility,
          'user_id_filter': userId,
        },
      );
    } else {
      response = await supabase.rpc(
        'get_nearby_memories',
        params: {
          'user_lat': position.latitude,
          'user_lng': position.longitude,
          'radius_meters': 1000,
          'limit_count': 20,
          'visibility_filter': visibility,
        },
      );
    }

    final List<MemoryModel> memories = (response)
        .map((json) => MemoryModel.fromMap(json))
        .toList();

    for (final memory in memories) {
      final photos = await getMemoryPhotos(memory.memoryId);
      memory.photos.addAll(photos);
    }
    return memories;
  }

  Future<List<PhotoModel>> getMemoryPhotos(String memoryId) async {
    final response =
        await supabase.from('photos').select().eq('m_id', memoryId) as List;
    final List<PhotoModel> photos = response
        .map((json) => PhotoModel.fromMap(json))
        .toList();

    return photos;
  }

  @override
  Future<List<MemoryModel>> getUserMemories({
    int offset = 0,
    int limit = 10,
  }) async {
    final supabase = getIt<SupabaseClient>();
    final user = supabase.auth.currentUser;
    final int start = offset * limit;
    final int end = start + limit - 1;
    final data = await supabase
        .from('memories')
        .select()
        .eq('u_id', user?.id ?? '')
        .order('created_at', ascending: false)
        .range(start, end);
    final records = data as List<dynamic>;
    final List<MemoryModel> memories = records
        .map((photoData) => MemoryModel.fromMap(photoData))
        .toList();

    for (final memory in memories) {
      final photos = await getMemoryPhotos(memory.memoryId);
      memory.photos.addAll(photos);
    }
    return memories;
  }
}
