import 'package:bookhub_prjct/models/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopRatedBooks extends StatelessWidget {
  final List<Book> books;

  const TopRatedBooks({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25,),
         Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Top Rated Books',
            // style: TextStyle(
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            //   color: Colors.black87,
            // ),
            style: theme.textTheme.headlineLarge,
          ),
        ),
        SizedBox(height: 25,),
        SizedBox(
          
          height: 450,
          child: ListView.builder(
            
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final topbook = books[index];
              
              return InkWell(
                 onTap: () {
                  context.go('/book/${topbook.id}');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          topbook.coverPic,
                          width: 200,
                          height: 250,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.broken_image,
                            size: 120,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        topbook.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        topbook.authorName,
                        style: theme.textTheme.bodySmall
                      ),
                      //const SizedBox(height: 8),
                      const SizedBox(width: 35,)
                    ],
                  ),
                ),
              );
            
            
            
            
            },
          ),
        ),
      ],
    );
  }
}

