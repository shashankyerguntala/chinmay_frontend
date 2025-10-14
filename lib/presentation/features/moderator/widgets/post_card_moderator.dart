import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_event.dart';

class PostCardModerator extends StatelessWidget {
  final PostEntity post;
  const PostCardModerator({super.key, required this.post});

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
                _iconBox(Icons.article_outlined, context),
                const SizedBox(width: 12),
                Expanded(child: _postInfo(context)),
              ],
            ),
            const SizedBox(height: 12),
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon, BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: ColorConstants.primaryColor.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(icon, size: 20, color: ColorConstants.primaryColor),
  );

  Widget _postInfo(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        post.title,
        style: ThemeConstants.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: HelperFunctions.getRoleColor(post.postStatus).withAlpha(20),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          post.postStatus.toUpperCase(),
          style: ThemeConstants.bodySmall.copyWith(
            color: ColorConstants.errorColor,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ),
    ],
  );

  Widget _actionButtons(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton.icon(
        onPressed: () => context.read<ModeratorBloc>().add(RejectPost(post.id)),
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
            context.read<ModeratorBloc>().add(ApprovePost(post.id)),
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
