import 'package:flutter/material.dart';
import 'package:warframemarket_app/widgets/background.dart';

class ListingsScreen extends StatelessWidget {
  const ListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/warframe_market_logo.png"),
          height: 60,
        ),
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 74, 100, 130),
      ),
      body: const Stack(children: [
        SarynBackground(),
      ]),
    );
  }
}
