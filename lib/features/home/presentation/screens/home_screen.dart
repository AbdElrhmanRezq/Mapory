import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/features/home/presentation/cubit/map_cubit/map_cubit.dart';
import 'package:mapory/features/home/presentation/screens/widgets/home_floating_action_button.dart';
import 'package:mapory/features/home/presentation/screens/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..init(context),
      child: Scaffold(
        body: HomeScreenBody(),
        floatingActionButton: HomeFloatingActionButton(),
      ),
    );
  }
}
