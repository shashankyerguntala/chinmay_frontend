import 'package:flutter/material.dart';

import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/presentation/features/home/widgets/flag_dialogue.dart';

class PostCard extends StatelessWidget {
  final String role;
  final String email;
  final String caption;
  final String description;
  final int commentsCount;
  final String createdAt;
  final VoidCallback onTap;
  final VoidCallback onFlag;

  const PostCard({
    super.key,
    required this.email,
    required this.caption,
    required this.description,
    required this.commentsCount,
    required this.createdAt,
    required this.onTap,
    required this.role,
    required this.onFlag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorConstants.borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryColor.withAlpha(5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorConstants.primaryColor,
                          ColorConstants.primaryLightColor,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorConstants.transparent,
                      child: Text(
                        email[0].toUpperCase(),
                        style: const TextStyle(
                          color: ColorConstants.fillColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: ColorConstants.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          createdAt,
                          style: const TextStyle(
                            fontSize: 12,
                            color: ColorConstants.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.fillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: role == StringConstants.moderator
                        ? IconButton(
                            onPressed: () => FlagDialogue.show(context, onFlag),
                            icon: Icon(
                              Icons.flag_circle,

                              size: 24,
                              color: ColorConstants.errorColor,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),

            if (caption.isNotEmpty || description.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (caption.isNotEmpty) ...[
                      Text(
                        caption,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.textPrimaryColor,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (description.isNotEmpty) ...[
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorConstants.textSecondaryColor,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.fillColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.fillColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 18,
                            color: ColorConstants.textSecondaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "$commentsCount ${commentsCount == 1 ? 'comment' : 'comments'}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
