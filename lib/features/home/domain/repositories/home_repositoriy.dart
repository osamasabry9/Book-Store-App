import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';

abstract class HomeRepository {
 Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks();
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks();
}