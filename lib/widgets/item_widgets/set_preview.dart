import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/game_object_loader.dart';
import 'package:warframemarket_app/widgets/item_widgets/item_preview.dart';

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
              itemURL: setData.set.imageURL,
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
                itemURL: setData.components[i].imageURL,
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
