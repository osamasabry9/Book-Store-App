import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookly/features/home/domain/usecases/fetch_featured_books_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/book_entity.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
      : super(FeaturedBooksInitial());

  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;

  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    emit(FeaturedBooksLoading());
    Either<Failure, List<BookEntity>> result =
        await fetchFeaturedBooksUseCase.call(pageNumber);

    result.fold(
      (failure) => emit(FeaturedBooksFailure(failure.message)),
      (books) => emit(FeaturedBooksSuccess(books)),
    );
  }
}
