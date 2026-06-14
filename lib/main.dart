import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book Finder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      getPages: [
        // GetPage(name: '/',        page: () => HomeScreen()),
        // GetPage(name: '/search',  page: () => SearchScreen()),
        // GetPage(name: '/book',    page: () => BookDetailScreen()),
        // GetPage(name: '/author',  page: () => AuthorScreen()),
        // GetPage(name: '/subject', page: () => SubjectScreen()),
        // GetPage(name: '/about',   page: () => AboutScreen()),
      ],
      home: const Scaffold(
        body: Center(
          child: Text(
            'Book Finder App',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
