import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/app_widget.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}