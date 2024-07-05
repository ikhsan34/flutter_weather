import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final Color? color;

  const FullWidthButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(20),
          foregroundColor: MaterialStatePropertyAll(color),
          maximumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
