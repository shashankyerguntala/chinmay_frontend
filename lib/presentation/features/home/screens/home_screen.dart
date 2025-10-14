import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';

import 'package:jay_insta_clone/domain/usecase/send_comment_usecase.dart';
import 'package:jay_insta_clone/presentation/features/home/home_bloc/home_event.dart';
import 'package:jay_insta_clone/presentation/features/home/comment_bloc/bloc/comment_bloc.dart';

import 'package:jay_insta_clone/presentation/features/home/widgets/post_card.dart';
import 'package:jay_insta_clone/presentation/features/home/widgets/post_details_sheet.dart';
import '../home_bloc/home_bloc.dart';

import '../home_bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(postUseCase: di<PostUseCase>(), commentUseCase: di())
            ..add(FetchPostsEvent()),
      child: Scaffold(
        backgroundColor: ColorConstants.fillColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            StringConstants.appTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.textPrimaryColor,
              fontSize: 22,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: ColorConstants.highlightColor,
                radius: 18,
                child: GestureDetector(
                  onTap: () {
                    context.go(StringConstants.profile);
                  },
                  child: Icon(
                    Icons.person,
                    color: ColorConstants.primaryLightColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is FlagSuccessState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.msg)));
            } else if (state is FlagErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.msg)));
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                final posts = state.posts;
                if (posts.isEmpty) {
                  return const Center(
                    child: Text(StringConstants.noPostsAvailable),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: posts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostCard(
                      email: post.author.username,
                      caption: post.title,
                      description: post.content,
                      commentsCount: post.comments!.length,
                      createdAt: post.createdAt!,
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: ColorConstants.transparent,
                        builder: (_) => BlocProvider(
                          create: (_) => CommentBloc(
                            commentUseCase: di<SendCommentUseCase>(),
                          ),
                          child: PostDetailsSheet(
                            post: post,
                            userId: widget.user.id,
                          ),
                        ),
                      ),
                      role: widget.user.role,
                      onFlag: () {
                        context.read<HomeBloc>().add(
                          FlagPostEvent(postId: post.id),
                        );
                      },
                    );
                  },
                );
              } else if (state is HomeError) {
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
