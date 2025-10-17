import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String action,
    required String itemType,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('$action $itemType?'),
        content: Text('Are you sure you want to $action this $itemType?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'Approve' ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(action),
          ),
        ],
      ),
    );
  }
}
