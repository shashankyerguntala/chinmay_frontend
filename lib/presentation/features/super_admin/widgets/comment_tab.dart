import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';

import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_state.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/confirmation_dialogue_box.dart';
import 'empty_state.dart';

class CommentTab extends StatelessWidget {
  final SuperAdminLoaded state;
  const CommentTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.comments.isEmpty) {
      return const EmptyState(
        icon: Icons.comment_outlined,
        message: 'No comments to review',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final comment = state.comments[index];
        final isPending = comment.commentStatus.toLowerCase() == 'pending';

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Comment by ${comment.author.username}',
                        style: ThemeConstants.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPending ? Colors.orange : Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        comment.commentStatus.toUpperCase(),
                        style: ThemeConstants.bodySmall.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  comment.content,
                  style: ThemeConstants.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isPending) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          final confirmed = await showConfirmationDialog(
                            context: context,
                            title: 'Reject Comment',
                            message:
                                'Are you sure you want to reject this comment?',
                            confirmText: 'Reject',
                            isDestructive: true,
                          );

                          if (confirmed && context.mounted) {
                            context.read<SuperAdminBloc>().add(
                              RejectCommentSuperAdmin(comment.id),
                            );
                          }
                        },
                        icon: const Icon(Icons.close, size: 18),
                        label: const Text('Reject'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final confirmed = await showConfirmationDialog(
                            context: context,
                            title: 'Approve Comment',
                            message:
                                'Are you sure you want to approve this comment?',
                            confirmText: 'Approve',
                          );

                          if (confirmed && context.mounted) {
                            context.read<SuperAdminBloc>().add(
                              ApproveCommentSuperAdmin(comment.id),
                            );
                          }
                        },
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('Approve'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
