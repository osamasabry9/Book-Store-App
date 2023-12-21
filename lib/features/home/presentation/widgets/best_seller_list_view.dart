import 'package:bookly/features/home/presentation/cubits/newest_books_cubit/newest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book_entity.dart';
import 'best_seller_list_view_item.dart';

class BestSellerListView extends StatefulWidget {
  const BestSellerListView({super.key, required this.bestBooks});

  final List<BookEntity> bestBooks;

  @override
  State<BestSellerListView> createState() => _BestSellerListViewState();
}

class _BestSellerListViewState extends State<BestSellerListView> {
  var isLoading = false;
  var nextPage = 1;

  late final ScrollController _scrollBestSellerController;

  @override
  void dispose() {
    _scrollBestSellerController.dispose();
    debugPrint("dispose Scroll position");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    debugPrint("init Scroll position: ");
    _scrollBestSellerController = ScrollController();
    _scrollBestSellerController.addListener(() {
      _scrollListener();
      debugPrint("listener Scroll position");
    });
  }

  ListView listViewWidget() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      controller: _scrollBestSellerController,
      itemCount: widget.bestBooks.length +
          1, // Add 1 to accommodate loading indicator or fetch more data
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < widget.bestBooks.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BookListViewItem(book: widget.bestBooks[index]),
          );
        } else {
          // Loading Indicator or Fetch more data
          return _buildLoader(); // Create a method to show a loading indicator
        }
      },
    );
  }

  void _scrollListener() async {
    var currentPositions = _scrollBestSellerController.position.pixels;
    var maxScrollLength = _scrollBestSellerController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {
      // Trigger request to fetch more data here
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks(
          pageNumber: nextPage++,
        );
        isLoading = false;
      }
    }
    debugPrint("Scroll position: $currentPositions");
  }

  Future loadMore() async {
    await BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks(
      pageNumber: nextPage++,
    );
  }

  Widget _buildLoader() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child:
            CircularProgressIndicator(), // Customize the loading indicator as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollInfo) {
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent
            ? loadMore()
            : null;
        return true;
      },
      child: listViewWidget(),
    );
  }
}
