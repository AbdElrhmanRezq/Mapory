import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/presentation/cubit/comments_cubit/comments_cubit.dart';
import 'package:mapory/features/home/presentation/cubit/user_comment_cubit/user_comment_cubit.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key, required this.memory});

  final MemoryModel memory;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCommentCubit, UserCommentState>(
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
      listener: (context, state) async {
        if (state is UserCommentSent) {
          (context).read<CommentsCubit>().addComment(state.comment);
        }
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
