import 'package:flutter/material.dart';
import 'package:ghackk_technologies/provider/theme_provider.dart';
import 'package:ghackk_technologies/screens/genres_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.blueGrey,
        appBarTheme: AppBarTheme(color: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade500,
        appBarTheme: AppBarTheme(color: Colors.deepPurple),
      ),
      home: GenresScreen(),
    );
  }
}
