import 'package:flutter/material.dart';
import 'package:warframemarket_app/item_loader.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Title Bar"), backgroundColor: Colors.blue),
      body: FutureBuilder(
        future: loadWarframeItem(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final item = snapshot.data!;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.itemName),
                Text(item.itemDescription),
              ],
            ),
          );
        },
      ),
    );
  }
}
