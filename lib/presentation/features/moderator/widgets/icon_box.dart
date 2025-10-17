import 'package:flutter/widgets.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

class IconBox extends StatelessWidget {
  final IconData icon;

  const IconBox({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: ColorConstants.primaryColor),
    );
  }
}
