// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'presentation/app_widget.dart';
// import 'providers/theme_provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:intern_app/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/app_widget.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()), // Add FavoriteProvider
      ],
      child: MyApp(),
    ),
  );
}
