// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'favorite_screen.dart';

// class NavigationBarWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Favorites',
//         ),
//       ],
//       onTap: (index) {
//         if (index == 0) {
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//             (route) => false,
//           );
//         } else if (index == 1) {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => FavoriteScreen()),
//           );
//         }
//       },
//     );
//   }
// }
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
  int _currentIndex = 0; // Track the current index of the selected item

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: CommonColor.primaryColor, // Background color of the bar
      color: Colors.white, // Color for unselected items
      activeColor: Colors.white, // Color for selected item
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.favorite, title: 'Favorites'),
      ],
      initialActiveIndex: _currentIndex, // Set the initial index
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Update the selected index
        });

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
