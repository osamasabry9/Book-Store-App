import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookly/features/home/domain/usecases/fetch_newest_books_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/book_entity.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  final FetchNewestBooksUseCase fetchNewestBooksUseCase;
  NewestBooksCubit(this.fetchNewestBooksUseCase) : super(NewestBooksInitial());

  Future<void> fetchNewestBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(NewestBooksLoading());
    } else {
      emit(NewestBooksPaginationLoading());
    }

    Either<Failure, List<BookEntity>> result =
        await fetchNewestBooksUseCase.call(pageNumber);
    result.fold(
      (failure) {
        if (pageNumber == 0) {
          emit(NewestBooksFailure(failure.message));
        } else {
          emit(NewestBooksPaginationFailure(failure.message));
        }
      },
      (books) => emit(NewestBooksSuccess(books)),
    );
  }
}
