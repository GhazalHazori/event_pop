import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? borderSide;
  final bool isElevated;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderSide,
    this.isElevated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    if (isElevated) {
      return SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: shape,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
          child: Text(text),
        ),
      );
    } else {
      return SizedBox(
        height: 44,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            side: borderSide ?? BorderSide.none,
            shape: shape,
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
          child: Text(text),
        ),
      );
    }
  }
}
