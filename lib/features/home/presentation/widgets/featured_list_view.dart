import 'package:flutter/material.dart';

import '../../domain/entities/book_entity.dart';
import 'custom_book_item.dart';

class FeaturedBooksListView extends StatelessWidget {
  final List<BookEntity> books;
  const FeaturedBooksListView({Key? key, required this.books})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
          itemCount: books.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomBookImage(
                image: books[index].image ?? "",
              ),
            );
          }),
    );
  }
}
