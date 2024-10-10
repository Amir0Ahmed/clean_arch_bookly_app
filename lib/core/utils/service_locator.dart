import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/repos/home_repo_imp.dart';
import 'package:clean_arch_bookly_app/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      Dio(),
    ),
  );
  getIt.registerLazySingleton<HomeRepoImp>(
    () => HomeRepoImp(
      HomeRemoteDataSource(
        apiService: getIt<ApiService>(),
      ),
      HomeLocalDataSource(),
    ),
  );
}
