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
  // Track the current selected index
  int _currentIndex = 0;

  // Define the screens for each tab
  final List<Widget> _screens = [
    // The main home content
    TabBarViewWidget(),
    // The favorites screen content
    FavoriteScreen(),
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
          //switch icon to change theme
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
      // Display the selected screen
      body: _screens[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: CommonColor.primaryColor,
        color: Colors.white,
        activeColor: Colors.white,
        items: const [
          //bottom navigation bar items
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.favorite, title: 'Favorites'),
        ],
        // Set the initial index
        initialActiveIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            // Update the selected index
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
