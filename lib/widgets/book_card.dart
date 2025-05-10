import 'package:bookhub_prjct/models/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  
  final Book book;

  const BookCard({super.key, required this.book});
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: InkWell(
      onTap: () {
        print('Navigating to BookDetailsScreen with bookId: ${book.id}');
        context.go('/book/${book.id}');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.coverPic,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 50,
                 
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: theme.textTheme.headlineMedium,
                    
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.authorName,
                     style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rating: ${book.rating ?? 'N/A'}',
                    style: theme.textTheme.bodyMedium,
                    //style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status: ${book.readStatus ?? 'Unknown'}',
                    style: theme.textTheme.bodyMedium,
                    //style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

