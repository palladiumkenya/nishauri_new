import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool loading;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle titleStyle;
  final VoidCallback onPress;

  CustomButton({
    required this.title,
    required this.loading,
    required this.backgroundColor,
    required this.textColor,
    required this.titleStyle,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.all(
              8.0), // Increase this value to increase the size of the button
        ),
        onPressed: loading ? null : onPress,
        child: Text(
          title,
          style: titleStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
