import 'package:flutter/material.dart';
import 'package:warframemarket_app/screens/listings_screen.dart';
import 'package:warframemarket_app/screens/search_screen.dart';
import 'package:warframemarket_app/screens/set_details_screen.dart';
import 'package:warframemarket_app/screens/sources_screen.dart';
import 'package:warframemarket_app/widgets/item_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ItemListProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routes: {
          "/": (_) => const SearchScreen(),
          "/set_details": (_) => const SetDetailsScreen(),
          "/listings": (_) => const ListingsScreen(),
          "/sources": (_) => const SourcesScreen(),
        },
        initialRoute: "/",
      ),
    );
  }
}
