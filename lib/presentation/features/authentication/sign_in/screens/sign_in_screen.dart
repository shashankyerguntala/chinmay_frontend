import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';

import 'package:jay_insta_clone/presentation/features/authentication/sign_in/widgets/sign_in_appbar.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/widgets/sign_in_form.dart';

import '../bloc/sign_in_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => di<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorConstants.errorColor,
              ),
            );
          } else if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  StringConstants.welcomeUser(state.username),
                  style: const TextStyle(color: Colors.black),
                ),
                backgroundColor: const Color.fromARGB(186, 25, 255, 48),
              ),
            );

            switch (state.role) {
              case "ADMIN":
                context.go(StringConstants.admin);
                break;
              case "SUPER_ADMIN":
                context.go(StringConstants.superAdmin);
                break;
              default:
                context.go(
                  StringConstants.home,
                  extra: {"uid": state.uid, "role": state.role},
                );
            }
          }
        },
        builder: (context, state) {
          final obscurePassword = state is SignInPasswordVisibilityChanged
              ? state.isPasswordObscured
              : true;
          final isLoading = state is SignInLoading;

          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SignInAppBar(),
                    const SizedBox(height: 12),
                    SignInForm(
                      formKey: formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                      obscurePassword: obscurePassword,
                      isLoading: isLoading,
                      onPasswordVisibilityToggle: () {
                        context.read<SignInBloc>().add(ShowPasswordEvent());
                      },
                      onSubmit: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          context.read<SignInBloc>().add(
                            SignInRequested(
                              name: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
