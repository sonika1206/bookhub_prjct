import 'dart:convert';
import 'book.dart';

class BookHub {
  final List<Book> books;
  final int total;

  BookHub({
    required this.books,
    required this.total,
  });

  BookHub copyWith({
    List<Book>? books,
    int? total,
  }) =>
      BookHub(
        books: books ?? this.books,
        total: total ?? this.total,
      );

  factory BookHub.fromRawJson(String str) => BookHub.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookHub.fromJson(Map<String, dynamic> json) => BookHub(
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "total": total,
      };
}