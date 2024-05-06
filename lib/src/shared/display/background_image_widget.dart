import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String svgImage;
  final String notFoundText;
  final CustomAppBar? customAppBar;
  final Color? backgroundColor;

  const BackgroundImageWidget({
    Key? key,
    this.customAppBar,
    required this.svgImage,
    required this.notFoundText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            svgImage,
            // fit: BoxFit.cover,
          ),
          if (customAppBar != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: customAppBar!,
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: Center(
              child: Text(
                notFoundText,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

