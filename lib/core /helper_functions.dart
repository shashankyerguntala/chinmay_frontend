import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';

class HelperFunctions {
  static String getRoleLabel(String role) {
    switch (role) {
      case "MODERATOR":
        return "Access Moderator Privileges";
      case "ADMIN":
        return "Access Admin Privileges";
      case "SUPER_ADMIN":
        return "Access Super Admin Privileges";
      default:
        return "Become a Moderator";
    }
  }

  static Color getRoleColor(String role) {
    switch (role) {
      case "MODERATOR":
        return const Color.fromARGB(255, 243, 93, 0);
      case "ADMIN":
        return Colors.purple;

      case "SUPER_ADMIN":
        return Colors.amber.shade700;
      default:
        return ColorConstants.primaryColor;
    }
  }

  static int getCurrentIndex(String location) {
    if (location.startsWith(StringConstants.home)) return 0;
    if (location.startsWith(StringConstants.create)) return 1;
    if (location.startsWith(StringConstants.profile)) return 2;
    return 0;
  }

  static void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
