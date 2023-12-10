import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.width = 300,
    this.height = 100,
    this.textSize = 35,
    this.borderSize = 5,
    this.imagePath,
    this.function,
  });

  final String text;
  final double width, height;
  final double textSize;
  final double borderSize;
  final String? imagePath;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(width, height)),
        backgroundColor: MaterialStatePropertyAll(Colors.grey.shade600),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              width: borderSize,
              color: (function != null)
                  ? const Color.fromARGB(255, 66, 170, 175)
                  : Colors.grey,
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
                const SizedBox(width: 5),
              ],
            ),
          Text(text,
              style: TextStyle(
                  fontSize: textSize,
                  color: (function != null)
                      ? const Color.fromARGB(255, 145, 208, 211)
                      : Colors.grey,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
