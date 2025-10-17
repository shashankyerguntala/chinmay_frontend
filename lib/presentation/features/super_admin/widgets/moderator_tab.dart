import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';

import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_state.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/confirmation_dialogue_box.dart';
import 'empty_state.dart';

class ModeratorTab extends StatelessWidget {
  final SuperAdminLoaded state;
  const ModeratorTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final pendingRequests = state.moderatorRequests
        .where((req) => req.status.toLowerCase() == 'pending')
        .toList();

    if (pendingRequests.isEmpty) {
      return const EmptyState(
        icon: Icons.person_add_outlined,
        message: 'No pending moderator requests to review',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: pendingRequests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final moderatorReq = pendingRequests[index];

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            moderatorReq.username,
                            style: ThemeConstants.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Request ID: ${moderatorReq.id}',
                            style: ThemeConstants.bodySmall.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'PENDING',
                        style: ThemeConstants.bodySmall.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Requested: ${HelperFunctions.formatDate(moderatorReq.requestedAt)}',
                      style: ThemeConstants.bodySmall.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        final confirmed = await showConfirmationDialog(
                          context: context,
                          title: 'Reject Moderator Request',
                          message:
                              'Are you sure you want to reject ${moderatorReq.username}\'s moderator request?',
                          confirmText: 'Reject',
                          isDestructive: true,
                        );

                        if (confirmed && context.mounted) {
                          context.read<SuperAdminBloc>().add(
                            RejectModeratorSuperAdmin(moderatorReq.id),
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
                          title: 'Approve Moderator Request',
                          message:
                              'Are you sure you want to approve ${moderatorReq.username} as a moderator?',
                          confirmText: 'Approve',
                        );

                        if (confirmed && context.mounted) {
                          context.read<SuperAdminBloc>().add(
                            ApproveModeratorSuperAdmin(moderatorReq.id),
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
            ),
          ),
        );
      },
    );
  }
}
