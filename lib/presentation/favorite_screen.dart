import 'package:flutter/material.dart';
import 'package:intern_app/providers/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'book_detail_screen.dart'; // Import the BookDetailScreen

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      body: favoriteProvider.favorites.isEmpty
          ? Center(
            //shows no favourites books yet if not choosed any book as favourite
              child: Text('No favorite books yet'),
            )
            //display the favourite item in card in listview
          : ListView.builder(
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final book = favoriteProvider.favorites[index];
                final imageUrl =
                    book['imageUrl'] ?? 'https://via.placeholder.com/50';

                return GestureDetector(
                  onTap: () {
                    // Navigate to BookDetailScreen when a card is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                  child: Card(
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
                      subtitle: Text(
                        (book['authors'] is List<dynamic>)
                            ? (book['authors'] as List<dynamic>).join(', ')
                            : 'No Author',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          favoriteProvider.toggleFavorite(book);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
