import 'package:flutter/material.dart';

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
      color: const Color.fromARGB(120, 20, 20, 20),
      colorBlendMode: BlendMode.multiply,
    );
  }
}
