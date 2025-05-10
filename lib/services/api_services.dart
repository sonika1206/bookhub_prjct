import 'dart:convert';
import 'package:bookhub_prjct/models/book_details_model.dart';
import 'package:bookhub_prjct/models/book_hub.dart';
import 'package:bookhub_prjct/models/top_rated_model.dart';
import 'package:bookhub_prjct/services/auth_services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<TopRated> getTopRatedBooks() async {
    try {
      final url = Uri.parse('https://apis.ccbp.in/book-hub/top-rated-books');
      final tokenObject = await AuthService().getToken(); 
            final token = tokenObject?.jwtToken;
      print('this is the auth token -taken from top_rated books $token');
      if (token == null) throw Exception('No token found');
      final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if(response.statusCode==200){
        return TopRated.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('top rated books not found: ${response.statusCode}');
      }
    } catch (e) {throw Exception('Failed to load top rated books: $e');}
  }

static const String baseUrl = 'https://apis.ccbp.in';

  Future<BookHub> getBooks(String bookshelf, String searchText) async {
    final tokenObject = await AuthService().getToken(); 
final token = tokenObject?.jwtToken;

    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/book-hub/books?shelf=$bookshelf&search=$searchText'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return BookHub.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load books: ${response.statusCode}');
  }


 Future<BookDetails> getBookDetails(String? bookId) async {
 final tokenObject = await AuthService().getToken(); 
final token = tokenObject?.jwtToken;
    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/book-hub/books/$bookId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print('API Response for bookId $bookId: $jsonData');
      //return BookDetails.fromJson(jsonDecode(response.body));
      return BookDetails.fromJson(jsonData['book_details']);
    }
    throw Exception('Failed to load book details: ${response.statusCode}');
  }

   Future<void> addToBookshelf(String bookId, String bookshelf) async {
    final token = await AuthService().getToken();
    if (token == null) throw Exception('No token found. Please log in again.');

    final response = await http.post(
      Uri.parse('$baseUrl/book-hub/add-to-bookshelf'),
      headers: {
        'Authorization': 'Bearer ${token.jwtToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'bookId': bookId,
        'bookshelf': bookshelf,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add book to bookshelf: ${response.statusCode} - ${response.body}');
    }
  }
}
