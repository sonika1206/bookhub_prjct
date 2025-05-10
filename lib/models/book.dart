import 'dart:convert';

class Book {
  final String id;
  final String title;
  final String authorName;
  final String coverPic;
  final String? rating;
  final String? bookshelf;
  final String? readStatus;

  Book({
    required this.id,
    required this.title,
    required this.authorName,
    required this.coverPic,
    this.rating,
    this.bookshelf,
    this.readStatus,
  });

  Book copyWith({
    String? id,
    String? title,
    String? authorName,
    String? coverPic,
    String? rating,
    String? bookshelf,
    String? readStatus,
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        authorName: authorName ?? this.authorName,
        coverPic: coverPic ?? this.coverPic,
        rating: rating ?? this.rating,
        bookshelf: bookshelf ?? this.bookshelf,
        readStatus: readStatus ?? this.readStatus,
      );

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"].toString(),
        title: json["title"],
        authorName: json["author_name"],
        coverPic: json["cover_pic"],
        rating: json["rating"]?.toString(),
        bookshelf: json["bookshelf"],
        readStatus: json["read_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author_name": authorName,
        "cover_pic": coverPic,
        "rating": rating,
        "bookshelf": bookshelf,
        "read_status": readStatus,
      };
}