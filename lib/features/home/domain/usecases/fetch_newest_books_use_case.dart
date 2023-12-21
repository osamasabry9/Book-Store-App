import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../entities/book_entity.dart';
import '../repositories/home_repository.dart';

class FetchNewestBooksUseCase extends BaseUseCase<List<BookEntity> , int> {
  final HomeRepository repository;

  FetchNewestBooksUseCase(this.repository);
@override
   Future<Either<Failure, List<BookEntity>>> call([int parameters =0]){
    
    return repository.fetchNewestBooks(pageNumber: parameters);
   }
}
