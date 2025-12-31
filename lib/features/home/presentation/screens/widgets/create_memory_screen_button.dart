import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/features/home/presentation/cubit/photos_cubit/photos_cubit.dart';

class CreateMemoryScreenButton extends StatelessWidget {
  const CreateMemoryScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: KMainBackground,
      onPressed: () {
        (context).read<PhotosCubit>().loadImagesFromDevice();
      },
      child: Icon(Icons.add, color: KMainColor),
    );
  }
}
