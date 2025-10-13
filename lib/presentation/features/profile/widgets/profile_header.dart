import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/moderator_request_dialogue.dart';

import 'package:jay_insta_clone/presentation/features/profile/widgets/sign_out_dialogue.dart';

import 'role_badge.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final List<String> roles;
  final bool hasRequestedModerator;
  final VoidCallback onModeratorRequest;
  final VoidCallback onSignOut;

  const ProfileHeader({
    super.key,

    required this.hasRequestedModerator,
    required this.onModeratorRequest,
    required this.onSignOut,
    required this.username,
    required this.email,
    required this.roles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryColor.withAlpha(8),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          RoleBadge(userRole: roles.last),
          const SizedBox(height: 16),
          Text(
            username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstants.textPrimaryColor,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(
              fontSize: 14,
              color: ColorConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          RoleBadge(userRole: roles.last, isTextBadge: true),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: hasRequestedModerator
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withAlpha(10),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.orange.withAlpha(30),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.hourglass_empty,
                              color: Colors.orange,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Moderator Request Pending",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HelperFunctions.getRoleColor(
                            roles.last,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          ModeratorRequestDialog.show(
                            context,
                            onModeratorRequest,
                          );
                        },
                        child: Text(
                          HelperFunctions.getRoleLabel(roles.last),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.borderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  color: ColorConstants.errorColor,
                  onPressed: () => SignOutDialog.show(context, onSignOut),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
