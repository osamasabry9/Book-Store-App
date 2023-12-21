import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/build_error_snack_bar_widget.dart';
import '../../domain/entities/book_entity.dart';
import '../cubits/newest_books_cubit/newest_books_cubit.dart';
import 'best_seller_list_view.dart';

class BestSellerListViewBlocConsumer extends StatefulWidget {
  const BestSellerListViewBlocConsumer({super.key});

  @override
  State<BestSellerListViewBlocConsumer> createState() =>
      _BestSellerListViewBlocConsumerState();
}

class _BestSellerListViewBlocConsumerState
    extends State<BestSellerListViewBlocConsumer> {
  List<BookEntity> bestBooks = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewestBooksCubit, NewestBooksState>(
      listener: (context, state) {
        if (state is NewestBooksSuccess) {
          bestBooks.addAll(state.books);
          debugPrint('${bestBooks.length}');
        }
        if (state is NewestBooksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              buildErrorSnackBarWidget(errorMessage: state.errorMessage));
        }
      },
      builder: (context, state) {
        if (state is NewestBooksSuccess ||
            state is NewestBooksPaginationLoading ||
            state is NewestBooksPaginationFailure) {
          return BestSellerListView(
            bestBooks: bestBooks,
          );
        } else if (state is NewestBooksFailure) {
          return Text(state.errorMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
