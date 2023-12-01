import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/home/data/datasources/home_local_data_source.dart';
import 'package:bookly/features/home/data/datasources/home_remote_data_source.dart';
import 'package:bookly/features/home/data/repositories/home_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';



final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app service client
  instance.registerSingleton<ApiService>(ApiService(Dio()));
  // // cubit
  // instance.registerFactory(
  //     () => FeaturedBooksCubit(instance<FetchFeaturedBooksUseCase>()));
  // instance.registerFactory(
  //     () => NewestBooksCubit(instance<FetchNewestBooksUseCase>()));

  // // custom data source
  // instance.registerSingleton<HomeRemoteDataSource>(
  //    HomeRemoteDataSourceImpl(instance<ApiService>()),
  // );

  // // remote data source
  // instance.registerSingleton<HomeRemoteDataSource>(
  //   HomeRemoteDataSourceImpl(instance<ApiService>()),
  // );

  // // local data source
  // instance.registerSingleton<HomeLocalDataSource>(
  //    HomeLocalDataSourceImpl(),
  // );

  // repository
  instance.registerSingleton<HomeRepositoryImpl>(
    HomeRepositoryImpl(
      remoteDataSource: HomeRemoteDataSourceImpl(instance.get<ApiService>()),
      localDataSource: HomeLocalDataSourceImpl(),
    ),
  );
// // use case
//   instance.registerSingleton(
//       () => FetchFeaturedBooksUseCase(instance<HomeRepository>()));
//   instance.registerSingleton(
//       () => FetchNewestBooksUseCase(instance<HomeRepository>()));
//
}
