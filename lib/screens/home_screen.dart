import 'package:bookhub_prjct/providers/book_provider.dart';
import 'package:bookhub_prjct/widgets/footer.dart';
import 'package:bookhub_prjct/widgets/header.dart';
import 'package:bookhub_prjct/widgets/top_rated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class TopRatedBooksScreen extends ConsumerWidget {
  const TopRatedBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final booksState = ref.watch(booksProvider);

    
    if (booksState.topRated == null && !booksState.isLoading && booksState.error == null) {
      ref.read(booksProvider.notifier).fetchTopRatedBooks();
    }

    return Scaffold(
      appBar: const Header(forceBackButton: false,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: theme.cardColor,
            // color: Colors.grey[100],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Find Your Next Favorite Books?',
                  style: theme.textTheme.headlineMedium,
                  // style: TextStyle(
                  //   fontSize: 24,
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.black87,
                  // ),
                ),
                const SizedBox(height: 18),
                Text(
                  'You are in the right place. Tell us what titles or genres you have enjoyed in the past, and we will give you surprisingly insightful recommendations.',
                  //style: TextStyle(fontSize: 16, color: Colors.black54),
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/search');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Find Books',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
          Expanded(
            child: booksState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : booksState.error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error: ${booksState.error}'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(booksProvider.notifier).refreshTopRatedBooks();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : booksState.topRated == null || booksState.topRated!.books.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.book_outlined,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                // const SizedBox(height: 16),
                                const Text(
                                  'No top rated books found',
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                ),
                                const SizedBox(height: 6),
                                ElevatedButton(
                                  onPressed: () {
                                    ref.read(booksProvider.notifier).refreshTopRatedBooks();
                                  },
                                  child: const Text('Refresh'),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                TopRatedBooks(books: booksState.topRated!.books),
                                const Footer(),
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}










