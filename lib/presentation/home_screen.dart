import 'package:flutter/material.dart';
import 'package:intern_app/common/constants.dart';
import 'package:intern_app/presentation/navigtion_bar_widget.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'tab_bar_view_widget.dart';

class HomeScreen extends StatelessWidget {
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
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarViewWidget(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}
