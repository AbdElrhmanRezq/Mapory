import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapory/core/widgets/simple_app_bar.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/photo_screen_body.dart';

class PhotoScreen extends StatelessWidget {
  final PhotoModel photo;
  const PhotoScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: PhotoScreenBody(photo: photo),
    );
  }
}
