import 'package:flutter/material.dart';

class CBButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final double padding;
  final double height;

  const CBButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.backgroundColor = Colors.black87,
    this.foregroundColor = Colors.white70,
    this.padding = 8.0,
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
          minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(height)),
        ),
        child: Text(title),
        onPressed: onPressed,
      ),
    );
  }
}
