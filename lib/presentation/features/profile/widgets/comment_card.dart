import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class CommentCard extends StatelessWidget {
  final CommentEntity comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorConstants.fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: ColorConstants.primaryLightColor.withAlpha(20),
            child: Icon(
              Icons.person,
              size: 20,
              color: ColorConstants.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.author.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.textSecondaryColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  comment.createdAt!,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
