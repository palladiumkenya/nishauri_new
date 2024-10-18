import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;

  const ImageCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of screen width
      height: 200, // Set a fixed height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.cover, // Ensures the image covers the entire card
        ),
      ),
    );
  }
}
