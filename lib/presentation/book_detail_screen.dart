
import 'package:flutter/material.dart';
import 'package:intern_app/common/constants.dart';

class BookDetailScreen extends StatelessWidget {
  final Map book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CommonColor.primaryColor,
        title: Text(
          book['title'] ?? 'Book Details',
          style: TextStyle(fontSize: 18, color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            Center(
              child: book['imageLinks'] != null
                  ? Image.network(
                      (book['imageLinks']['thumbnail'] ?? '')
                          .replaceAll('http:', 'https:'),
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 100);
                      },
                    )
                  : Icon(Icons.book, size: 100),
            ),
            SizedBox(height: 20),

            // Book Title
            Text(
              book['title'] ?? 'No Title',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Book Authors
            Text(
              'Author(s): ${book['authors']?.join(', ') ?? 'No Author'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 5),

            // Published Date
            Text(
              'Published Date: ${book['publishedDate'] ?? 'Unknown'}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Divider(height: 30, color: Colors.grey[300]),

            // Book Description
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              book['description'] ?? 'No description available for this book.',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}