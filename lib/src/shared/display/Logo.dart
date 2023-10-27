import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, });

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("assets/images/logo-1.jpg"), fit: BoxFit.fill, width: 150,);
  }
}
