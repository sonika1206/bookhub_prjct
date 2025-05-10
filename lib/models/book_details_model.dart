import 'dart:convert';

class Detailed {
  final BookDetails bookDetails;

  Detailed({required this.bookDetails});

  Detailed copyWith({BookDetails? bookDetails}) =>
      Detailed(bookDetails: bookDetails ?? this.bookDetails);

  factory Detailed.fromRawJson(String str) =>
      Detailed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detailed.fromJson(Map<String, dynamic> json) =>
      Detailed(bookDetails: BookDetails.fromJson(json["book_details"]));

  Map<String, dynamic> toJson() => {"book_details": bookDetails.toJson()};
}

class BookDetails {
  final String id;
  final String title;
  final String readStatus;
  final double rating;
  final String authorName;
  final String coverPic;
  final String aboutBook;
  final String aboutAuthor;
  final String bookshelf;

  BookDetails({
    required this.id,
    required this.title,
    required this.readStatus,
    required this.rating,
    required this.authorName,
    required this.coverPic,
    required this.aboutBook,
    required this.aboutAuthor,
    required this.bookshelf,
  });

  BookDetails copyWith({
    String? id,
    String? title,
    String? readStatus,
    double? rating,
    String? authorName,
    String? coverPic,
    String? aboutBook,
    String? aboutAuthor,
    String? bookshelf,
  }) => BookDetails(
    id: id ?? this.id,
    title: title ?? this.title,
    readStatus: readStatus ?? this.readStatus,
    rating: rating ?? this.rating,
    authorName: authorName ?? this.authorName,
    coverPic: coverPic ?? this.coverPic,
    aboutBook: aboutBook ?? this.aboutBook,
    aboutAuthor: aboutAuthor ?? this.aboutAuthor,
    bookshelf: bookshelf?? this.bookshelf,
  );

  factory BookDetails.fromRawJson(String str) =>
      BookDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    print('Parsing BookDetails JSON: $json');
    return BookDetails(
      id: json["id"]?.toString() ?? '',
      title: json["title"]?.toString() ?? 'Unknown Title',
      readStatus: json["read_status"]?.toString() ?? 'Unknown',
      rating: json["rating"]?.toDouble() ?? 0.0,
      authorName: json["author_name"]?.toString() ?? 'Unknown Author',
      coverPic: json["cover_pic"]?.toString() ?? '',
      aboutBook: json["about_book"]?.toString() ?? '',
      aboutAuthor: json["about_author"]?.toString() ?? '',
      bookshelf: json['book status']?.toString()??''
    );
  }

  get author => null;

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "read_status": readStatus,
    "rating": rating,
    "author_name": authorName,
    "cover_pic": coverPic,
    "about_book": aboutBook,
    "about_author": aboutAuthor,
    'book Shelf': bookshelf,
  };
}