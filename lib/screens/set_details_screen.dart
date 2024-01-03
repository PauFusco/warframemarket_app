import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/game_object_loader.dart';
import 'package:warframemarket_app/widgets/background.dart';
import 'package:warframemarket_app/widgets/custom_button.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_description.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_preview.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_title.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_values_box.dart';
import 'package:warframemarket_app/widgets/item_widgets/set_preview.dart';

class SetDetailsScreen extends StatelessWidget {
  const SetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? setToLoad =
        ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
          title: const Image(
            image: AssetImage("assets/warframe_market_logo.png"),
            height: 60,
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 74, 100, 130)),
      body: FutureBuilder(
        future: loadGameObject(setToLoad!),
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
          if (dataRequest is GenericSetData) {
            return SetDetailsLayout(dataRequest: dataRequest);
          } else if (dataRequest is GameItem) {
            return ItemDetailsLayout(dataRequest: dataRequest);
          } else {
            return Center(child: Text("Data Type Not Found"));
          }
        },
      ),
    );
  }
}

class SetDetailsLayout extends StatefulWidget {
  const SetDetailsLayout({
    super.key,
    required this.dataRequest,
  });

  final GenericSetData dataRequest;

  @override
  State<SetDetailsLayout> createState() => _SetDetailsLayoutState();
}

class _SetDetailsLayoutState extends State<SetDetailsLayout> {
  int activeItem = 0;

  void setActiveItem(int itemNum) {
    setState(() {
      activeItem = itemNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SarynBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemTitle(
                  fullSetName: widget.dataRequest.set.itemName.toUpperCase(),
                  itemName: (activeItem == 0)
                      ? widget.dataRequest.set.itemName.toUpperCase()
                      : widget.dataRequest.components[activeItem - 1].itemName
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
                  setData: widget.dataRequest,
                  selectedItem: activeItem,
                  updateState: setActiveItem),
              ItemDescription(
                  description: (activeItem == 0)
                      ? widget.dataRequest.set.itemDescription
                      : widget.dataRequest.components[activeItem - 1]
                          .itemDescription),
              ValuesBox(
                masteryLevel: (activeItem == 0)
                    ? widget.dataRequest.set.masteryLevel
                    : widget
                        .dataRequest.components[activeItem - 1].masteryLevel,
                tradingTax: (activeItem == 0)
                    ? widget.dataRequest.set.tradingTax
                    : widget.dataRequest.components[activeItem - 1].tradingTax,
                ducats: (activeItem == 0)
                    ? widget.dataRequest.set.ducats
                    : widget.dataRequest.components[activeItem - 1].ducats,
              ),
              CustomButton(
                text: "LISTINGS",
                function: () {
                  Navigator.pushNamed(context, "/listings",
                      arguments: (activeItem == 0)
                          ? widget.dataRequest.set.itemName
                          : widget
                              .dataRequest.components[activeItem - 1].itemName);
                },
              ),
              CustomButton(
                text: "SOURCES",
                function: (activeItem != 0)
                    ? () {
                        Navigator.pushNamed(context, "/sources",
                            arguments: (activeItem == 0)
                                ? widget.dataRequest.set.itemName
                                : widget.dataRequest.components[activeItem - 1]
                                    .itemName);
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemDetailsLayout extends StatefulWidget {
  const ItemDetailsLayout({
    super.key,
    required this.dataRequest,
  });

  final GameItem dataRequest;

  @override
  State<ItemDetailsLayout> createState() => _ItemDetailsLayoutState();
}

class _ItemDetailsLayoutState extends State<ItemDetailsLayout> {
  int activeItem = 0;

  void setActiveItem(int itemNum) {
    setState(() {
      activeItem = itemNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SarynBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemTitle(
                  fullSetName: widget.dataRequest.itemName.toUpperCase(),
                  itemName: widget.dataRequest.itemName.toUpperCase()),
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
              ItemPreview(
                itemURL: widget.dataRequest.imageURL,
                size: 300,
                isActive: true,
                positionInList: 0,
                updateState: null,
              ),
              ItemDescription(description: widget.dataRequest.itemDescription),
              ValuesBox(
                masteryLevel: null,
                ducats: null,
                tradingTax: widget.dataRequest.tradingTax,
                maxRank: widget.dataRequest.maxRank,
                rarity: widget.dataRequest.rarity,
              ),
              CustomButton(
                text: "LISTINGS",
                function: () {
                  Navigator.pushNamed(context, "/listings",
                      arguments: widget.dataRequest.itemName);
                },
              ),
              CustomButton(
                text: "SOURCES",
                function: (activeItem != 0)
                    ? () {
                        Navigator.pushNamed(context, "/sources",
                            arguments: widget.dataRequest.itemName);
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
