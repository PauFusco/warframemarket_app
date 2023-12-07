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
      routes: {
        "/": (_) => const HomePage(),
      },
      initialRoute: "/",
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Image(
            image: AssetImage("assets/warframe_market_logo.png"),
            height: 60,
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 74, 100, 130)),
      body: FutureBuilder(
        future: loadWarframeSet("wisp_prime"),
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
              alignment: Alignment.center,
              children: [
                const SarynBackground(),
                Column(
                  children: [
                    SetInformation(dataRequest: dataRequest),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SarynBackground extends StatelessWidget {
  const SarynBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/saryn_background.png",
      height: 973, //image height
      fit: BoxFit.none,
      color: const Color.fromARGB(100, 80, 80, 80),
      colorBlendMode: BlendMode.srcATop,
    );
  }
}

class SetInformation extends StatelessWidget {
  const SetInformation({
    super.key,
    required this.dataRequest,
  });

  final WarframeSetData dataRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ItemTitle(itemName: dataRequest.set.itemName.toUpperCase()),
        SetPreview(setData: dataRequest),
        ItemDescription(description: dataRequest.set.itemDescription),
      ],
    );
  }
}

class ItemDescription extends StatelessWidget {
  const ItemDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.grey.shade700, width: 6)),
      child: Center(
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
    required this.itemName,
  });

  final String itemName;

  @override
  Widget build(BuildContext context) {
    final splitted = itemName.split("PRIME");

    String setName = "${splitted[0]}PRIME";
    String componentName = splitted[1];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          setName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          componentName,
          style: const TextStyle(
            color: Color.fromARGB(255, 27, 147, 178),
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SetPreview extends StatelessWidget {
  const SetPreview({
    super.key,
    required this.setData,
  });

  final WarframeSetData setData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ItemPreview(item: setData.set, width: 300, height: 300),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ItemPreview(item: setData.blueprint, width: 80, height: 80),
            ItemPreview(item: setData.neuroptics, width: 80, height: 80),
            ItemPreview(item: setData.chassis, width: 80, height: 80),
            ItemPreview(item: setData.systems, width: 80, height: 80),
          ],
        ),
      ],
    );
  }
}

class ItemPreview extends StatelessWidget {
  const ItemPreview(
      {super.key,
      required this.item,
      required this.width,
      required this.height});

  final WarframeItem item;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade700,
        border: Border.all(
          width: 3,
          color: (item.itemName.contains("Set")
              ? const Color.fromARGB(255, 95, 245, 255)
              : const Color.fromARGB(255, 92, 92, 92)),
        ),
        image: DecorationImage(
          image: NetworkImage(item.imageURL),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
