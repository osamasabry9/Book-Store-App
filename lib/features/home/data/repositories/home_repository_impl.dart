import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks(
      {int pageNumber = 0}) async {
    try {
      List<BookEntity> booksList;
      booksList = localDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      if (booksList.isNotEmpty) {
        return Right(booksList);
      }
      booksList =
          await remoteDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      return Right(booksList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks(
      {int pageNumber = 0}) async {
    try {
      List<BookEntity> booksList;
      booksList = localDataSource.fetchNewestBooks(pageNumber: pageNumber);
      if (booksList.isNotEmpty) {
        return Right(booksList);
      }
      booksList =
          await remoteDataSource.fetchNewestBooks(pageNumber: pageNumber);
      return Right(booksList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
