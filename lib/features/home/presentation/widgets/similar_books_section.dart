import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';
import '../../domain/entities/book_entity.dart';
import 'similar_books_list_view.dart';

class SimilarBooksSection extends StatelessWidget {
  final BookEntity book;
  const SimilarBooksSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You can also like',
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SimilarBooksListView(
          book: book,
        ),
      ],
    );
  }
}
