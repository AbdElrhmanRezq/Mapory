import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/cubit/user_comment_cubit/user_comment_cubit.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key, required this.memory});

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCommentCubit, UserCommentState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            maxLines: 3,
            minLines: 1,
            cursorColor: KMainColor,
            textAlignVertical: TextAlignVertical.top,
            controller: context.read<UserCommentCubit>().commentController,
            decoration: InputDecoration(
              hintText: "Add a comment...",
              suffixIcon: IconButton(
                onPressed: state is UserCommentSending
                    ? null
                    : () {
                        context.read<UserCommentCubit>().addComment(
                          memoryId: memory.memoryId,
                        );
                      },
                icon: SentIcon(state: state),
              ),
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}

class SentIcon extends StatelessWidget {
  final UserCommentState state;
  const SentIcon({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is UserCommentSending) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: KMainColor),
      );
    } else if (state is UserCommentFailure) {
      return const Icon(Icons.error, color: Colors.red);
    } else if (state is UserCommentSent) {
      return const Icon(Icons.check, color: Colors.green);
    }
    return Icon(Icons.send, color: KMainColor);
  }
}
