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
    final nameController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => di<SignInBloc>(),
      child: BlocListener<SignInBloc, SignInState>(
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
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: const Color.fromARGB(186, 25, 255, 48),
              ),
            );
            context.go(
              StringConstants.home,
              extra: {"uid": state.uid, "role": state.role},
            );
          }
        },
        child: Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SignInAppBar(),
                  const SizedBox(height: 12),
                  BlocListener<SignInBloc, SignInState>( ////////
                    listener: (context, state) {
                      if (state is SignInSuccess) {
                        if (state.role == "ADMIN") { /////////enums
                          context.go(StringConstants.admin);
                        } else if (state.role == "SUPER_ADMIN") {
                          context.go(StringConstants.superAdmin);
                        }
                      }
                    },
                    child: Container(),
                  ),
                   BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      final obscurePassword =
                          state is SignInPasswordVisibilityChanged
                          ? state.isPasswordObscured
                          : true;
                      final isLoading = state is SignInLoading;

                      return SignInForm(
                        formKey: formKey,
                        emailController: nameController,
                        passwordController: passwordController,
                        obscurePassword: obscurePassword,
                        isLoading: isLoading,
                        onPasswordVisibilityToggle: () {
                          context.read<SignInBloc>().add(ShowPasswordEvent());
                        },
                        onSubmit: () {
                          if (formKey.currentState!.validate()) { /////DISABLE KEYBOARD
                            context.read<SignInBloc>().add(
                              SignInRequested(
                                name: nameController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
