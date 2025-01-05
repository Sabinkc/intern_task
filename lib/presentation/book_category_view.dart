import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

import 'book_detail_screen.dart';

class BookCategoryView extends StatelessWidget {
  final String category;

  BookCategoryView({required this.category});

  Future<List> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'] ?? [];
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show shimmer effect while loading
          return ListView.builder(
            itemCount: 5, // Show 5 loading shimmer cards
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                    title: Container(
                      height: 10,
                      color: Colors.white,
                    ),
                    subtitle: Container(
                      height: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final books = snapshot.data ?? [];
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index]['volumeInfo'];
              final imageUrl = book['imageLinks']?['thumbnail'] ??
                  'https://via.placeholder.com/50'; // Fallback image URL
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(
                    imageUrl,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image,
                          size: 50); // Fallback icon
                    },
                  ),
                  title: Text(book['title'] ?? 'No Title'),
                  subtitle: Text(book['authors']?.join(', ') ?? 'No Author'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
