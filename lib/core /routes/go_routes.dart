import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/screen/add_admin_screen.dart';
import 'package:jay_insta_clone/presentation/features/admin/screens/admin_screen.dart';

import 'package:jay_insta_clone/presentation/features/authentication/sign_in/screens/sign_in_screen.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/screens/sign_up_screen.dart';
import 'package:jay_insta_clone/presentation/features/create_post/screens/create_post.dart';

import 'package:jay_insta_clone/presentation/features/home/screens/home_screen.dart';
import 'package:jay_insta_clone/presentation/features/moderator/screen/moderator_screen.dart';
import 'package:jay_insta_clone/presentation/features/profile/screens/profile_screen.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/screens/super_admin_screen.dart';
import 'package:jay_insta_clone/presentation/widgets/main_shell.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: StringConstants.signIn,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) {
              final extra = state.extra;
              final UserEntity user;

              if (extra != null && extra is UserEntity) {
                user = extra;
              } else {
                user = UserEntity(
                  username: 'shash',
                  email: 'shash@gmail.com',
                  role: 'AUTHOR',
                  id: 0,
                );
              }
              return HomeScreen(user: user);
            },
          ),
          GoRoute(
            path: StringConstants.create,
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>? ?? {};
              final isEdit = extra['isEdit'] as bool? ?? false;
              final post = extra['post'] as PostEntity?;
              return CreatePost(isEdit: isEdit, post: post);
            },
          ),
          GoRoute(
            path: StringConstants.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: StringConstants.signIn,
        builder: (context, _) => const SignInScreen(),
      ),
      GoRoute(
        path: StringConstants.signUp,
        builder: (context, _) => SignUpScreen(),
      ),
      GoRoute(
        path: StringConstants.admin,
        builder: (context, _) => const AdminScreen(),
      ),
      GoRoute(
        path: StringConstants.moderator,
        builder: (context, _) => const ModeratorScreen(),
      ),
      GoRoute(
        path: StringConstants.superAdmin,
        builder: (context, _) => const SuperAdminScreen(),
      ),
      GoRoute(
        path: StringConstants.addAdmin,
        builder: (context, _) => const AddAdminScreen(),
      ),
    ],
  );
}
