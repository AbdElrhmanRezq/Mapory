import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapory/core/widgets/simple_app_bar.dart';
import 'package:mapory/features/home/presentation/cubit/photos_cubit/photos_cubit.dart';
import 'package:mapory/features/home/presentation/screens/widgets/create_memory_screen_body.dart';
import 'package:mapory/features/home/presentation/screens/widgets/create_memory_screen_button.dart';

class CreateMemoryScreen extends StatelessWidget {
  final LatLng position;
  const CreateMemoryScreen({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        actions: [
          IconButton(
            onPressed: () {
              (context).read<PhotosCubit>().uploadPhotos();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: CreateMemoryScreenBody(position: position),
      floatingActionButton: CreateMemoryScreenButton(),
    );
  }
}
