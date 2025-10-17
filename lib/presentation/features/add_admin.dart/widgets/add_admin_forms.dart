import 'package:flutter/material.dart';
import 'package:jay_insta_clone/presentation/features/create_post/widgets/custom_input_decoration.dart';

class AdminFormFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AdminFormFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: CustomInputDecoration.inputDecoration("Username"),
          validator: (val) => val == null || val.isEmpty ? 'Enter username' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: emailController,
          decoration: CustomInputDecoration.inputDecoration("Email"),
          keyboardType: TextInputType.emailAddress,
          validator: (val) {
            if (val == null || val.isEmpty) return 'Enter email';
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            return emailRegex.hasMatch(val) ? null : 'Enter valid email';
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: CustomInputDecoration.inputDecoration("Password"),
          obscureText: true,
          validator: (val) => val == null || val.isEmpty ? 'Enter password' : null,
        ),
      ],
    );
  }
}
