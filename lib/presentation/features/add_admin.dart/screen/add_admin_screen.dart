import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/domain/usecase/admin_usecase.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/bloc/add_admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/bloc/add_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/bloc/add_admin_state.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/widgets/add_admin_forms.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/widgets/submit_button.dart';

class AddAdminScreen extends StatefulWidget {
  const AddAdminScreen({super.key});

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddAdminBloc(adminUseCase: di<AdminUseCase>()),
      child: Scaffold(
        backgroundColor: ColorConstants.fillColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.fillColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Add Admin",
            style: TextStyle(
              color: ColorConstants.textPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocConsumer<AddAdminBloc, AddAdminState>(
              listener: (context, state) {
                if (state is AddAdminSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.go(StringConstants.superAdmin);
                } else if (state is AddAdminFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is AddAdminLoading;

                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AdminFormFields(
                        usernameController: usernameController,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const Spacer(),
                      SubmitButton(
                        isLoading: isLoading,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            context.read<AddAdminBloc>().add(
                              AddAdminSubmitted(
                                name: usernameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
