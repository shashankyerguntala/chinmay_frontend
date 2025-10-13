import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/presentation/features/admin/widgets/moderator_request_tab.dart';

import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';
import '../widgets/posts_tab.dart';
import '../widgets/comments_tab.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminBloc(adminUseCase: di(), moderatorUseCase: di())
            ..add(FetchAllAdmin()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Dashboard', style: ThemeConstants.headingMedium),
          centerTitle: true,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                AuthLocalStorage.clearToken();
                context.go('/signin');
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.exit_to_app),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: ColorConstants.textSecondaryColor,
                  indicator: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: const [
                    Tab(text: 'Posts'),
                    Tab(text: 'Comments'),
                    Tab(text: 'Moderators'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  PostsTab(posts: state.posts),
                  CommentsTab(comments: state.comments),
                  ModeratorRequestTab(
                    moderatorRequests: state.moderatorRequests,
                  ),
                ],
              );
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

}
