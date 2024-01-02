import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/item_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';
import 'package:warframemarket_app/widgets/custom_button.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_description.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_title.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_values_box.dart';
import 'package:warframemarket_app/widgets/item_widgets/set_preview.dart';

class SetDetailsScreen extends StatefulWidget {
  const SetDetailsScreen({super.key});

  @override
  State<SetDetailsScreen> createState() => _SetDetailsScreenState();
}

class _SetDetailsScreenState extends State<SetDetailsScreen> {
  int activeItem = 0;

  void setActiveItem(int itemNum) {
    setState(() {
      activeItem = itemNum;
    });
  }

  @override
  Widget build(BuildContext context) {

    final String? setToLoad = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
          title: const Image(
            image: AssetImage("assets/warframe_market_logo.png"),
            height: 60,
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 74, 100, 130)),
      body: FutureBuilder(
        future: loadGenericSet(setToLoad!),
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
                    CustomButton(
                      text: "Wiki",
                      textSize: 20,
                      width: 100,
                      height: 35,
                      borderSize: 1.5,
                      imagePath: "assets/lotusSymbol.png",
                      function: () {
                        debugPrint("Wiki Button Pressed");
                      },
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
                    CustomButton(
                      text: "LISTINGS",
                      function: () {
                        Navigator.pushNamed(context, "/listings");
                      },
                    ),
                    CustomButton(
                      text: "SOURCES",
                      function: (activeItem != 0)
                          ? () {
                              Navigator.pushNamed(context, "/sources");
                            }
                          : null,
                    ),
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
