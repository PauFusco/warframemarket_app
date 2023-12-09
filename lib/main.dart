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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomButton(
                      text: "Wiki",
                      textSize: 13,
                      width: 80,
                      height: 30,
                      borderSize: 1.5,
                    ),
                    SetInformation(dataRequest: dataRequest),
                    const CustomButton(text: "LISTINGS"),
                    const CustomButton(text: "SOURCES"),
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

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.width = 250,
    this.height = 100,
    this.textSize = 30,
    this.borderSize = 5,
  });

  final String text;
  final double width;
  final double height;
  final double textSize;
  final double borderSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(width, height)),
        backgroundColor: MaterialStatePropertyAll(Colors.grey.shade600),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              width: borderSize,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: textSize,
              color: Colors.grey,
              fontWeight: FontWeight.w700)),
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
        ValuesBox(
          masteryLevel: dataRequest.set.masteryLevel,
          tradingTax: dataRequest.set.tradingTax,
          ducats: dataRequest.set.ducats,
        )
      ],
    );
  }
}

class ValuesBox extends StatelessWidget {
  const ValuesBox({
    super.key,
    required this.masteryLevel,
    required this.tradingTax,
    required this.ducats,
  });

  final int masteryLevel;
  final int tradingTax;
  final int ducats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 70,
      decoration: const BoxDecoration(
          color: Color.fromARGB(150, 139, 139, 139),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ValueProperty(propertyName: "Mastery Lvl", value: masteryLevel),
          ValueProperty(propertyName: "Trading Tax", value: tradingTax),
          ValueProperty(propertyName: "Ducats", value: ducats),
        ],
      ),
    );
  }
}

class ValueProperty extends StatelessWidget {
  const ValueProperty({
    super.key,
    required this.propertyName,
    required this.value,
  });

  final String propertyName;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(propertyName,
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 0.9)),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
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
          border: Border.all(color: Colors.grey.shade700, width: 6),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
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
