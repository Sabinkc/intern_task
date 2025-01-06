import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_app/providers/favourite_provider.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book_detail_screen.dart';

class CategoryViewScreen extends StatelessWidget {
  final String category;

  CategoryViewScreen({required this.category});

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
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return FutureBuilder<List>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 5,
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
                  'https://via.placeholder.com/50';

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(
                    imageUrl,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 50);
                    },
                  ),
                  title: Text(book['title'] ?? 'No Title'),
                  subtitle: Text(book['authors']?.join(', ') ?? 'No Author'),
                  trailing: IconButton(
                    icon: Icon(
                      favoriteProvider.isFavorite(book)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteProvider.isFavorite(book)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      favoriteProvider.toggleFavorite(book);
                    },
                  ),
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
