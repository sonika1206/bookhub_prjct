import 'package:bookhub_prjct/models/book_hub.dart';
import 'package:bookhub_prjct/models/top_rated_model.dart';
import 'package:bookhub_prjct/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final booksProvider = StateNotifierProvider<BooksNotifier, BooksState>((ref) {
  return BooksNotifier(ApiService());
});

class BooksState {
  final BookHub? searchResults;
  final TopRated? topRated;
  final bool isLoading;
  final String? error;

  BooksState({
    this.searchResults,
    this.topRated,
    this.isLoading = false,
    this.error,
  });

  BooksState copyWith({
    BookHub? searchResults,
    TopRated? topRated,
    bool? isLoading,
    String? error,
  }) {
    return BooksState(
      searchResults: searchResults ?? this.searchResults,
      topRated: topRated ?? this.topRated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class BooksNotifier extends StateNotifier<BooksState> {
  final ApiService _apiService;

  BooksNotifier(this._apiService) : super(BooksState()) {
    fetchTopRatedBooks();
  }

  Future<void> fetchTopRatedBooks() async {
    if (state.topRated != null && state.topRated!.books.isNotEmpty) {
      print('Top rated books already loaded, skipping fetch');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final topRated = await _apiService.getTopRatedBooks();
      state = state.copyWith(topRated: topRated, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchBooks(String bookshelf, String searchText) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchResults = await _apiService.getBooks(bookshelf, searchText);
      state = state.copyWith(searchResults: searchResults, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void refreshTopRatedBooks() {
    state = state.copyWith(topRated: null); 
    fetchTopRatedBooks();
  }
}