import 'package:flutter/material.dart';
import 'package:warframemarket_app/model/game_object_loader.dart';

class ItemPreview extends StatelessWidget {
  const ItemPreview({
    super.key,
    required this.itemURL,
    required this.size,
    this.opacity = 255,
    this.isActive = false,
    this.positionInList = 0,
    this.updateState,
  });

  final String itemURL;
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
          image: NetworkImage(itemURL),
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
