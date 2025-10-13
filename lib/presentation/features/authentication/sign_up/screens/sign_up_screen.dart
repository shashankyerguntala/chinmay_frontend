import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

import 'package:jay_insta_clone/presentation/features/authentication/sign_in/screens/sign_in_screen.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/widgets/sign_up_appbar.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/widgets/sign_up_form.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (_) => di<SignUpBloc>(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorConstants.errorColor,
              ),
            );
          } else if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                backgroundColor: ColorConstants.successColor,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SignInScreen()),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is SignUpLoading;
          final obscurePassword = state is SignUpPasswordVisibilityChanged
              ? state.isPasswordObscured
              : true;

          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SignUpAppBar(),
                    const SizedBox(height: 24),
                    SignUpForm(
                      formKey: formKey,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      obscurePassword: obscurePassword,
                      onPasswordVisibilityToggle: () {
                        context.read<SignUpBloc>().add(ShowPasswordEvent());
                      },
                      onSubmit: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                            SignUpRequested(
                              username: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      isLoading: isLoading,
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
// class _SignUpScreenBody extends StatelessWidget {
//   const _SignUpScreenBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
