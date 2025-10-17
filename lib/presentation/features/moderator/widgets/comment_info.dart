import 'package:flutter/widgets.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class CommentInfo extends StatelessWidget {
  final CommentEntity comment;

  const CommentInfo({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.content,
          style: ThemeConstants.bodyMedium,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: HelperFunctions.getRoleColor(
              comment.commentStatus,
            ).withAlpha(20),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            comment.commentStatus.toUpperCase(),
            style: ThemeConstants.bodySmall.copyWith(
              color: ColorConstants.errorColor,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
