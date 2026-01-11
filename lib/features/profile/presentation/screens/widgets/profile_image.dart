import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/functions/cache_fix.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:mapory/features/profile/presentation/cubit/user_images_cubit/user_images_cubit.dart'
    show UserImagesCubit;
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.height,
    required this.width,
    required this.user,
    this.isPublic = false,
  });

  final double height;
  final double width;
  final UserModel user;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height * 0.23,
      left: width * 0.333,
      child: GestureDetector(
        onTap: () async {
          final SupabaseClient supabase = getIt.get<SupabaseClient>();
          if (!isPublic) {
            await BlocProvider.of<UserImagesCubit>(
              context,
            ).uploadUserImage('profile_image');
            await BlocProvider.of<UserDataCubit>(context).fetchUserData();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: KMainBackground,
            borderRadius: BorderRadius.circular(100),
            border: Border.fromBorderSide(
              BorderSide(color: KMainColor, width: 3),
            ),
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(cacheFix(user.profileImage)),
          ),
        ),
      ),
    );
  }
}
