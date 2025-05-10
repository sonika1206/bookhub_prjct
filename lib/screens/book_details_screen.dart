import 'package:bookhub_prjct/models/book_details_model.dart';
import 'package:bookhub_prjct/services/api_services.dart';
import 'package:bookhub_prjct/widgets/footer.dart';
import 'package:bookhub_prjct/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final bookDetailsProvider = FutureProvider.family<BookDetails, String>(
  (ref, bookId) {
    print('Fetching book details for bookId: $bookId');
    return ApiService().getBookDetails(bookId);
  },
);

class BookDetailsScreen extends ConsumerStatefulWidget {
  final String bookId;

  const BookDetailsScreen({super.key, required this.bookId});

  @override
  ConsumerState<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends ConsumerState<BookDetailsScreen> {
  String? _selectedBookshelf;

  @override
  Widget build(BuildContext context) {
    final bookDetailsAsync = ref.watch(bookDetailsProvider(widget.bookId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const Header(),
      floatingActionButton: bookDetailsAsync.when(
        data: (book) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (book.bookshelf == null)
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Add to Bookshelf'),
                        content: DropdownButtonFormField<String>(
                          value: _selectedBookshelf,
                          decoration: const InputDecoration(
                            labelText: 'Select Bookshelf',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'READ', child: Text('Read')),
                            DropdownMenuItem(value: 'Currently Reading', child: Text('Currently Reading')),
                            DropdownMenuItem(value: 'Want To Read', child: Text('Want To Read')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedBookshelf = value;
                            });
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //     _addToBookshelf(context);
                          //   },
                          //   child: const Text('Add'),
                          // ),
                        ],
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                  tooltip: 'Add to Bookshelf',
                ),
              const SizedBox(height: 16),
              // FloatingActionButton(
              //   onPressed: () => _addToCart(book),
              //   child: const Icon(Icons.shopping_cart),
              //   tooltip: 'Add to Cart',
              // ),
            ],
          );
        },
        loading: () => null,
        error: (error, stackTrace) => null,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.brightness == Brightness.light ? Colors.grey : Colors.grey[800]!,
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: bookDetailsAsync.when(
          data: (book) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.all(16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Image.network(
                                    book.coverPic.isNotEmpty ? book.coverPic : 'https://via.placeholder.com/120x180',
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.broken_image,
                                      size: 200,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  book.coverPic.isNotEmpty ? book.coverPic : 'https://via.placeholder.com/120x180',
                                  width: 220,
                                  height: 330,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.broken_image,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            book.title,
                            style: theme.textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'By ${book.author}',
                            style: theme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Rating: ${book.rating}',
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (book.bookshelf != null) ...[
                          const SizedBox(height: 12),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Chip(
                                  avatar: Icon(
                                    book.bookshelf == 'READ'
                                        ? Icons.check_circle
                                        : book.bookshelf == 'Currently Reading'
                                            ? Icons.access_time
                                            : Icons.bookmark_border,
                                    size: 20,
                                  ),
                                  label: Text(
                                    'In: ${book.bookshelf}',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    _selectedBookshelf = book.bookshelf;
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Change Bookshelf'),
                                        content: DropdownButtonFormField<String>(
                                          value: _selectedBookshelf,
                                          decoration: const InputDecoration(
                                            labelText: 'Select Bookshelf',
                                            border: OutlineInputBorder(),
                                          ),
                                          items: const [
                                            DropdownMenuItem(value: 'READ', child: Text('Read')),
                                            DropdownMenuItem(value: 'Currently Reading', child: Text('Currently Reading')),
                                            DropdownMenuItem(value: 'Want To Read', child: Text('Want To Read')),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedBookshelf = value;
                                            });
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text('Change'),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     IconButton(
                        //       icon: const Icon(Icons.share),
                        //       onPressed: () {
                        //         try {
                        //           Share.share('Check out this book: ${book.title} by ${book.author}');
                        //         } catch (e) {
                        //           print('Error sharing book: $e');
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(
                        //               content: Text('Error sharing book: $e'),
                        //             ),
                        //           );
                        //         }
                        //       },
                        //       tooltip: 'Share Book',
                        //     ),
                        //   ],
                        // ),
                        Text(
                          'About Book',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.aboutBook.isNotEmpty ? book.aboutBook: 'No description available.',
                          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'About Author',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.aboutAuthor.isNotEmpty ? book.aboutAuthor : 'No description available.',
                          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Footer(),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            print('Error in bookDetailsProvider for bookId ${widget.bookId}: $error\nStackTrace: $stackTrace');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: $error',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.refresh(bookDetailsProvider(widget.bookId));
                    },
                    child: const Text('Retry'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    child: const Text('Go Back to Home'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}