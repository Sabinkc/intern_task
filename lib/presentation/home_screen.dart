import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'tab_bar_view_widget.dart';
import 'favorite_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart'; // Import for the navigation bar
import 'package:intern_app/common/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track the current selected index

  // Define the screens for each tab
  final List<Widget> _screens = [
    TabBarViewWidget(), // The main home content
    FavoriteScreen(), // The favorites screen content
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Finder App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: CommonColor.primaryColor,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 37,
            )),
      ),
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: ConvexAppBar(
        backgroundColor:
            CommonColor.primaryColor, // Background color of the bar
        color: Colors.white, // Color for unselected items
        activeColor: Colors.white, // Color for the selected item
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.favorite, title: 'Favorites'),
        ],
        initialActiveIndex: _currentIndex, // Set the initial index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}
