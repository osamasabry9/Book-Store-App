import 'package:flutter/material.dart';

import '../../domain/entities/book_entity.dart';
import '../widgets/book_details_view_body.dart';

class BookDetailsView extends StatelessWidget {
  final BookEntity book;
  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BookDetailsViewBody(
          book: book,
        ),
      ),
    );
  }
}
