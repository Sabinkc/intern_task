

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_app/providers/favourite_provider.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';


import 'book_detail_screen.dart';

class CategoryViewScreen extends StatelessWidget {
  final String category;

  CategoryViewScreen({required this.category});

  Future<List> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$category'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['items'] ?? [];
      } else {
        throw Exception('Failed to fetch books: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Failed to fetch books. Please check your internet connection and try again.');
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 50, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'Oops! Something went wrong.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Please check your internet connection or try again later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Retry the request when the button is pressed
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          CategoryViewScreen(category: category),
                    ));
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
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
