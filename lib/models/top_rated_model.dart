
import 'dart:convert';
import 'book.dart';

class TopRated {
  final List<Book> books;
  final int total;

  TopRated({
    required this.books,
    required this.total,
  });

  TopRated copyWith({
    List<Book>? books,
    int? total,
  }) =>
      TopRated(
        books: books ?? this.books,
        total: total ?? this.total,
      );

  factory TopRated.fromRawJson(String str) => TopRated.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopRated.fromJson(Map<String, dynamic> json) => TopRated(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "total": total,
      };
}