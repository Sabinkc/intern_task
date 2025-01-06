
import 'package:flutter/material.dart';
import 'package:intern_app/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/app_widget.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //provider to handle light and dark theme
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        //provider to handle favourite items
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}
