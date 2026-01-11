import 'package:flutter/material.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';

class MemoryScreenBody extends StatelessWidget {
  final MemoryModel memory;
  const MemoryScreenBody({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(memory.caption)]);
  }
}
