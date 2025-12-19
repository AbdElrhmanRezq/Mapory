import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_cubit.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_state.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () async {
            await context.read<MapCubit>().getCurrentLocation();
          },
        );
      },
    );
  }
}
