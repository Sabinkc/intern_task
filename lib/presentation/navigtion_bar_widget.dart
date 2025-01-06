
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart'; // Import the package
import 'package:intern_app/common/constants.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';

class NavigationBarWidget extends StatefulWidget {
  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  // Track the current index of the selected item
  int _currentIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: CommonColor.primaryColor, 
      color: Colors.white, 
      activeColor: Colors.white, 
      items: const [
        //items in bottom navigation bar
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
//logic for displaying data based on selected bottom navigation index
        if (index == 0) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        } else if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FavoriteScreen()),
          );
        }
      },
    );
  }
}
