import 'package:flutter/material.dart';
import 'package:warframemarket_app/screens/listings_screen.dart';
import 'package:warframemarket_app/screens/set_details_screen.dart';
import 'package:warframemarket_app/screens/sources_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        "/": (_) => const SetDetailsScreen(),
        "/listings": (_) => const ListingsScreen(),
        "/sources": (_) => const SourcesScreen(),
      },
      initialRoute: "/",
    );
  }
}
