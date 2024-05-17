import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? width;
  const Logo({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage("assets/images/logo.png"),
      fit: BoxFit.fill,
      width: width ?? 150,
    );
  }
}
