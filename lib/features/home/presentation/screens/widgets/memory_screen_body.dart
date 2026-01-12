import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/functions/reformate_date.dart';
import 'package:mapory/core/utils/functions/time_ago.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/cubit/user_comment_cubit/user_comment_cubit.dart';
import 'package:mapory/features/home/presentation/screens/widgets/comment_text_field.dart';
import 'package:mapory/features/home/presentation/screens/widgets/dot_indicator.dart';
import 'package:mapory/features/home/presentation/screens/widgets/memory_user_info.dart';
import 'package:mapory/features/home/presentation/screens/widgets/photo_slider.dart';
import 'package:mapory/features/profile/presentation/cubit/external_user_cubit/external_user_cubit.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';

class MemoryScreenBody extends StatelessWidget {
  final MemoryModel memory;
  const MemoryScreenBody({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MemoryUserInfo(memory: memory),
        PhotoSlider(memory: memory),
        DotIndicator(memory: memory, currentIndex: currentIndex),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(memory.caption, style: Styles.textStyle18),
        ),
        CommentTextField(memory: memory),
      ],
    );
  }
}
