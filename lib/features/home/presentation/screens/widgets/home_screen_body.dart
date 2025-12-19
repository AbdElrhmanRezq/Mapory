import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_cubit.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_state.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => HomeScreenBodyState();
}

class HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Scaffold(
          body: GoogleMap(
            style: state.mapStyle,
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357),
              zoom: 12,
            ),
            markers: state.markers,
            onMapCreated: (controller) {
              context.read<MapCubit>().setController(controller);
            },
          ),
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color.fromRGBO(181, 181, 181, 0.3),
      child: IconButton(
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kProfile);
        },
        icon: Icon(Icons.person, color: KMainColor),
      ),
    );
  }
}
