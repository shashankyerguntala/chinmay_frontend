import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_event.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/comment_info.dart';
import 'package:jay_insta_clone/presentation/features/moderator/widgets/icon_box.dart';

class CommentCard extends StatelessWidget {
  final dynamic comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBox(icon: Icons.chat_bubble_outline),
                const SizedBox(width: 12),
                Expanded(child: CommentInfo(comment: comment)),
              ],
            ),
            const SizedBox(height: 12),
            actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget actionButtons(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton.icon(
        onPressed: () =>
            context.read<ModeratorBloc>().add(RejectComment(comment.id)),
        icon: const Icon(Icons.close, size: 18),
        label: const Text('Decline'),
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      const SizedBox(width: 8),
      ElevatedButton.icon(
        onPressed: () =>
            context.read<ModeratorBloc>().add(ApproveComment(comment.id)),
        icon: const Icon(Icons.check, size: 18),
        label: const Text('Approve'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ],
  );
}
