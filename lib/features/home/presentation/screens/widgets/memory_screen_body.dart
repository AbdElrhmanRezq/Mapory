import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/screens/widgets/dot_indicator.dart';
import 'package:mapory/features/home/presentation/screens/widgets/photo_slider.dart';

class MemoryScreenBody extends StatelessWidget {
  final MemoryModel memory;
  const MemoryScreenBody({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Column(
      children: [
        PhotoSlider(memory: memory),
        DotIndicator(memory: memory, currentIndex: currentIndex),
      ],
    );
  }
}
