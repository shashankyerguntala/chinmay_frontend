import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/core%20/helper_functions.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';

import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_event.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_state.dart';

import 'package:jay_insta_clone/presentation/features/profile/widgets/post_tab.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc profileBloc;
  @override
  void initState() {
    super.initState();
    profileBloc = di<ProfileBloc>();
    AuthLocalStorage.getUid().then((uid) {
      if (uid != null) {
        profileBloc.add(FetchUserDetailsEvent(userId: uid));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is DeleteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(StringConstants.postDeleted)),
            );
          }
          if (state is ProfileSignedOut) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signed Out Successful')),
            );
            AuthLocalStorage.clearToken();
            context.go('/signin');
          } else if (state is ProfileModeratorSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Moderator request sent!")),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorConstants.fillColor,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(
                color: ColorConstants.textPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                color: ColorConstants.textPrimaryColor,
                onPressed: () {},
              ),
            ],
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded ||
                  state is ProfileModeratorSuccess) {
                final loadedState = state as ProfileLoaded;

                final isModerator = loadedState.isModeratorRequest;

                return DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      ProfileHeader(
                        hasRequestedModerator: isModerator,
                        onModeratorRequest: () {
                          if (state.roles.last == "AUTHOR") {
                            context.read<ProfileBloc>().add(
                              BecomeModeratorEvent(),
                            );
                          } else if (state.roles.last == "MODERATOR") {
                            context.push('/moderator');
                          } else if (state.roles.last == "ADMIN") {
                            context.push('/admin');
                          } else if (state.roles.last == "SUPER_ADMIN") {
                            context.push('/superadmin');
                          }
                        },
                        onSignOut: () {
                          context.read<ProfileBloc>().add(SignOutEvent());
                        },
                        username: state.username,
                        email: state.email,
                        roles: state.roles,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: ColorConstants.backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(10),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor:
                              ColorConstants.textSecondaryColor,
                          indicator: BoxDecoration(
                            color: HelperFunctions.getRoleColor(
                              state.roles.last,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.all(4),
                          tabs: [
                            Tab(text: "Approved"),
                            Tab(text: "Pending"),
                            Tab(text: "Declined"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            PostsTab(posts: loadedState.approvedPosts),
                            PostsTab(posts: loadedState.pendingPosts),
                            PostsTab(posts: loadedState.declinedPosts),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
