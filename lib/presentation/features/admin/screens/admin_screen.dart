import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';

import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_state.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/comment_tab.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/empty_state.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/moderator_tab.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/widgets/post_tab.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SuperAdminBloc(adminUseCase: di(), moderatorUseCase: di())
            ..add(FetchAllSuperAdmin()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.admin_panel_settings,
                color: ColorConstants.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text('Admin', style: ThemeConstants.headingMedium),
            ],
          ),
          bottom: TabBar(
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
        body: BlocConsumer<SuperAdminBloc, SuperAdminState>(
          listener: (context, state) {
            if (state is SuperAdminError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SuperAdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SuperAdminLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  PostTab(state: state),
                  CommentTab(state: state),
                  ModeratorTab(state: state),
                ],
              );
            }
            return const EmptyState(
              icon: Icons.inbox,
              message: 'No data available',
            );
          },
        ),
      ),
    );
  }
}
