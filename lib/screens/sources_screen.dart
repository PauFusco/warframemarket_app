import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_source_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';
import 'package:warframemarket_app/widgets/item_source_banner.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  Widget build(BuildContext context) {
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
        future: loadAllSources(
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
                Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          for (var relic in dataRequest.relics)
                            ItemSourceBanner(
                              source: relic,
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          for (var mission in dataRequest.missions)
                            ItemSourceBanner(
                              source: mission,
                            )
                        ],
                      ),
                      Column(
                        children: [
                          for (var npc in dataRequest.npcs)
                            ItemSourceBanner(
                              source: npc,
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
