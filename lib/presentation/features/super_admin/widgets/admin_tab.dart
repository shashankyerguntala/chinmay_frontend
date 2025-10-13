import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';

import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_state.dart';
import 'empty_state.dart';

class AdminTab extends StatelessWidget {
  final SuperAdminLoaded state;
  const AdminTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.posts.isEmpty) {
      return const EmptyState(
        icon: Icons.article_outlined,
        message: 'No Admin requests to review',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.adminRequests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = state.posts[index];
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
                Text(
                  post.title,
                  style: ThemeConstants.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(post.content, style: ThemeConstants.bodySmall),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: post.postStatus == 'pending'
                          ? () => context.read<SuperAdminBloc>().add(
                              RejectPostSuperAdmin(post.id),
                            )
                          : null,
                      icon: const Icon(Icons.close),
                      label: const Text('Reject'),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: post.postStatus == 'pending'
                          ? () => context.read<SuperAdminBloc>().add(
                              ApprovePostSuperAdmin(post.id),
                            )
                          : null,
                      icon: const Icon(Icons.check),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
