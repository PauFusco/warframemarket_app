import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_source_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final String? itemToLoad =
        ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/warframe_market_logo.png"),
          height: 50,
        ),
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 74, 100, 130),
      ),
      body: FutureBuilder(
        future: loadAllRelicSources(
          itemToLoad!.toLowerCase().replaceAll(" ", "_"),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Stack(
              alignment: Alignment.center,
              children: [
                SarynBackground(),
                CircularProgressIndicator(),
              ],
            );
          }
          final dataRequest = snapshot.data!;
          return Center(
            child: Stack(
              children: [
                const SarynBackground(),
                Container(
                  color: const Color.fromARGB(230, 17, 24, 27),
                ),
                Column(
                  children: [
                    for (var item in dataRequest)
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: Text(
                          item.relicName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
