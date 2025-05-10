

import 'package:bookhub_prjct/screens/book_details_screen.dart';
import 'package:bookhub_prjct/screens/home_screen.dart';
import 'package:bookhub_prjct/screens/login_screen.dart';
import 'package:bookhub_prjct/screens/search_books_screen.dart';
import 'package:bookhub_prjct/services/auth_services.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => TopRatedBooksScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchBooksScreen(),
    ),
    GoRoute(
      path: '/book/:id',
      builder: (context, state) {
        final bookId= state.pathParameters['id']!;
        return BookDetailsScreen(bookId: bookId);
      }
      
    ),
  ],
  redirect: (context, state) async {
    final bool isAuthenticated = await AuthService().isAuthenticated();
    if (isAuthenticated && state.uri.toString() == '/login') {
      return '/home';
    }
    if (!isAuthenticated && state.uri.toString() != '/login') {
      return '/login';
    }
    return null; 
  },
);