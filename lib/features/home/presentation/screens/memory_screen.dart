import 'package:flutter/material.dart';
import 'package:mapory/core/widgets/simple_app_bar.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/screens/widgets/memory_screen_body.dart';

class MemoryScreen extends StatelessWidget {
  final MemoryModel memory;
  const MemoryScreen({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: MemoryScreenBody(memory: memory),
    );
  }
}
