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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeItem = 0;

  void setActiveItem(int itemNum) {
    setState(() {
      activeItem = itemNum;
    });
  }

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
        future: loadGenericSet("wisp_prime"),
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
                    ItemTitle(
                        itemName: (activeItem == 0)
                            ? dataRequest.set.itemName.toUpperCase()
                            : dataRequest.components[activeItem - 1].itemName
                                .toUpperCase()),
                    const CustomButton(
                      text: "Wiki",
                      textSize: 20,
                      width: 100,
                      height: 35,
                      borderSize: 1.5,
                      imagePath: "assets/lotusSymbol.png",
                    ),
                    SetPreview(
                        setData: dataRequest,
                        selectedItem: activeItem,
                        updateState: setActiveItem),
                    ItemDescription(
                        description: (activeItem == 0)
                            ? dataRequest.set.itemDescription
                            : dataRequest
                                .components[activeItem - 1].itemDescription),
                    ValuesBox(
                      masteryLevel: (activeItem == 0)
                          ? dataRequest.set.masteryLevel
                          : dataRequest.components[activeItem - 1].masteryLevel,
                      tradingTax: (activeItem == 0)
                          ? dataRequest.set.tradingTax
                          : dataRequest.components[activeItem - 1].tradingTax,
                      ducats: (activeItem == 0)
                          ? dataRequest.set.ducats
                          : dataRequest.components[activeItem - 1].ducats,
                    ),
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
    this.width = 300,
    this.height = 100,
    this.textSize = 35,
    this.borderSize = 5,
    this.imagePath,
  });

  final String text;
  final double width, height;
  final double textSize;
  final double borderSize;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(width, height)),
        backgroundColor: MaterialStatePropertyAll(Colors.grey.shade600),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null)
            Row(
              children: [
                Image(
                  image: AssetImage(imagePath!),
                ),
                SizedBox(width: 5),
              ],
            ),
          Text(text,
              style: TextStyle(
                  fontSize: textSize,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700)),
        ],
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

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: setName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: componentName,
            style: const TextStyle(
              color: Color.fromARGB(255, 27, 147, 178),
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SetPreview extends StatelessWidget {
  const SetPreview({
    super.key,
    required this.setData,
    required this.selectedItem,
    this.updateState,
  });

  final GenericSetData setData;
  final int selectedItem;
  final void Function(int)? updateState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            ItemPreview(
              item: setData.set,
              size: 300,
              isActive: (selectedItem == 0),
              positionInList: 0,
              updateState: updateState,
            ),
            const SizedBox(height: 20),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < setData.components.length; i++)
              ItemPreview(
                item: setData.components[i],
                size: 80,
                opacity: 220,
                isActive: (selectedItem == i + 1),
                positionInList: i + 1,
                updateState: updateState,
              )
          ],
        ),
      ],
    );
  }
}

class ItemPreview extends StatelessWidget {
  const ItemPreview({
    super.key,
    required this.item,
    required this.size,
    this.opacity = 255,
    this.isActive = false,
    this.positionInList = 0,
    this.updateState,
  });

  final WarframeItem item;
  final double size;
  final int opacity;
  final bool isActive;
  final int positionInList;
  final void Function(int)? updateState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(opacity, 97, 97, 97),
        border: Border.all(
          width: 3,
          color: (isActive
              ? Color.fromARGB(opacity, 95, 245, 255)
              : Color.fromARGB(opacity, 92, 92, 92)),
        ),
        boxShadow: [
          if (isActive)
            BoxShadow(
                color: Color.fromARGB(opacity, 46, 113, 119),
                blurRadius: 20,
                spreadRadius: 3)
        ],
        image: DecorationImage(
          image: NetworkImage(item.imageURL),
          opacity: opacity.toDouble() / 255.0,
          fit: BoxFit.contain,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (updateState != null) {
            updateState?.call(positionInList);
          }
        },
      ),
    );
  }
}
