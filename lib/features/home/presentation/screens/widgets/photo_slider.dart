import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/cubit/slider_cubit/slider_cubit.dart';

class PhotoSlider extends StatelessWidget {
  const PhotoSlider({super.key, required this.memory, this.onPageChanged});

  final MemoryModel memory;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        return CarouselSlider(
          items: [
            ...memory.photos.map(
              (photo) => Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(photo.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ].toList(),
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            height: 250,
            viewportFraction: 0.95,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              context.read<SliderCubit>().updateIndex(index);
              if (onPageChanged != null) {
                onPageChanged!(index, reason);
              }
            },
          ),
        );
      },
    );
  }
}
