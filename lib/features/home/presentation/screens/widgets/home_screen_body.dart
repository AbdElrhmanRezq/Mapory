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
          body: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                style: state.mapStyle,
                myLocationEnabled: state.permissionGranted,
                initialCameraPosition: CameraPosition(
                  target: const LatLng(30.0444, 31.2357),
                  zoom: context.read<MapCubit>().zoom,
                ),
                markers: state.markers,
                onMapCreated: (controller) {
                  context.read<MapCubit>().setController(controller);
                },
                onLongPress: (LatLng position) {
                  print(position);
                },
              ),
              ProfileButton(),
            ],
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
    return Positioned(
      top: 36,
      right: 12,
      child: CircleAvatar(
        backgroundColor: KMainBackground,
        child: IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kProfile);
          },
          icon: Icon(Icons.person, color: KMainColor),
        ),
      ),
    );
  }
}
