import 'package:flutter/material.dart';

class Meds extends StatelessWidget {
  const Meds({super.key, });

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("assets/images/medicines.png"), fit: BoxFit.fill, width: 150,);
  }
}