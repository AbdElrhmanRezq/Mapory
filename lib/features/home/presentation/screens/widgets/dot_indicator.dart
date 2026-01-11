import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/cubit/slider_cubit/slider_cubit.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.memory,
    required this.currentIndex,
  });

  final MemoryModel memory;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: memory.photos
              .asMap()
              .entries
              .map(
                (item) => Container(
                  height: 8,
                  width: 8,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.currentIndex == item.key
                        ? KMainColor
                        : Colors.grey,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
