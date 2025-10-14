import 'package:get_it/get_it.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/admin_data_source.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/auth_data_source.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/comment_data_source.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/moderator_data_source.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/post_data_source.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/profile_data_source.dart';

import 'package:jay_insta_clone/data%20/repository_impl/admin_repo_impl.dart';
import 'package:jay_insta_clone/data%20/repository_impl/auth_repo_impl.dart';
import 'package:jay_insta_clone/data%20/repository_impl/comment_repo_impl.dart';
import 'package:jay_insta_clone/data%20/repository_impl/moderator_repo_impl.dart';
import 'package:jay_insta_clone/data%20/repository_impl/post_repo_impl.dart';
import 'package:jay_insta_clone/data%20/repository_impl/profile_repo_impl.dart';

import 'package:jay_insta_clone/domain/repository/admin_repository.dart';
import 'package:jay_insta_clone/domain/repository/auth_repo.dart';
import 'package:jay_insta_clone/domain/repository/comment_repository.dart';
import 'package:jay_insta_clone/domain/repository/moderator_repository.dart';
import 'package:jay_insta_clone/domain/repository/post_repository.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

import 'package:jay_insta_clone/domain/usecase/admin_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/auth_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/moderator_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/profile_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/send_comment_usecase.dart';

import 'package:jay_insta_clone/presentation/features/admin/bloc/admin_bloc.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:jay_insta_clone/presentation/features/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:jay_insta_clone/presentation/features/home/home_bloc/home_bloc.dart';
import 'package:jay_insta_clone/presentation/features/moderator/bloc/moderator_bloc.dart';
import 'package:jay_insta_clone/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_bloc.dart';

GetIt di = GetIt.instance;

class Di {
  static Future<void> init() async {
    ////////////ADD TAGS
    di.registerLazySingleton(() => DioClient());
    di.registerLazySingleton(() => AuthRemoteDataSource(dioClient: di()));
    di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: di()),
    );
    di.registerLazySingleton(() => AuthUsecase(repository: di()));
    di.registerFactory(() => SignInBloc(authUsecase: di()));
    di.registerFactory(() => SignUpBloc(authUsecase: di()));

    di.registerLazySingleton<PostDataSource>(() => PostDataSource(di()));

    di.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(di()));

    di.registerLazySingleton<PostUseCase>(() => PostUseCase(di()));

    di.registerFactory<HomeBloc>(
      () => HomeBloc(postUseCase: di(), commentUseCase: di()),
    );

    di.registerLazySingleton(() => ProfileDataSource(dioClient: di()));
    di.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(dataSource: di()),
    );
    di.registerLazySingleton(() => ProfileUsecase(di()));
    di.registerLazySingleton(() => ProfileBloc(profileUsecase: di(), di()));
    di.registerLazySingleton(() => ModeratorDataSource(dioClient: di()));
    di.registerLazySingleton<ModeratorRepository>(
      () => ModeratorRepositoryImpl(dataSource: di()),
    );
    di.registerLazySingleton(() => ModeratorUseCase(repository: di()));
    di.registerFactory(() => ModeratorBloc(useCase: di()));

    di.registerLazySingleton(() => CommentDataSource(dio: di()));
    di.registerLazySingleton<CommentRepository>(() => CommentRepoImpl(di()));
    di.registerLazySingleton(() => SendCommentUseCase(di()));

    di.registerLazySingleton(() => AdminDataSource(dioClient: di()));
    di.registerLazySingleton<AdminRepository>(
      () => AdminRepositoryImpl(dataSource: di()),
    );
    di.registerLazySingleton(() => AdminUseCase(repository: di()));
    di.registerFactory(
      () => AdminBloc(adminUseCase: di(), moderatorUseCase: di()),
    );

    di.registerFactory(
      () => SuperAdminBloc(adminUseCase: di(), moderatorUseCase: di()),
    );
  }
}
