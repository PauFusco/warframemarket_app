import 'package:flutter/material.dart';

class BuySellButton extends StatelessWidget {
  const BuySellButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.active,
    this.function,
  });

  final String text;
  final double width, height;
  final VoidCallback? function;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: active
            ? const Border(
                bottom: BorderSide(
                  width: 3,
                  color: Color.fromARGB(255, 24, 149, 126),
                ),
              )
            : null,
      ),
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(
            Size(width, 40),
          ),
          backgroundColor: const MaterialStatePropertyAll(
            Color.fromARGB(255, 23, 30, 33),
          ),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active
                ? const Color.fromARGB(255, 24, 151, 127)
                : const Color.fromARGB(255, 50, 114, 131),
          ),
        ),
      ),
    );
  }
}
