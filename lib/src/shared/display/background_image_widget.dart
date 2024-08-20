import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String svgImage;
  final String notFoundText;
  final CustomAppBar? customAppBar;
  final Color? backgroundColor;
  final double? svgWidth;
  final double? svgHeight;
  final IconData? floatingButtonIcon1;
  final VoidCallback? floatingButtonAction1;
  final IconData? floatingButtonIcon2;
  final VoidCallback? floatingButtonAction2;

  const BackgroundImageWidget({
    Key? key,
    this.customAppBar,
    required this.svgImage,
    required this.notFoundText,
    this.backgroundColor,
    this.svgWidth,
    this.svgHeight,
    this.floatingButtonIcon1,
    this.floatingButtonAction1,
    this.floatingButtonIcon2,
    this.floatingButtonAction2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            svgImage,
            width: svgWidth,
            height: svgHeight,
            fit: BoxFit.scaleDown,
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
                textAlign: TextAlign.center,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (floatingButtonIcon1 != null && floatingButtonAction1 != null)
            FloatingActionButton(
              onPressed: floatingButtonAction1,
              child: Icon(floatingButtonIcon1),
            ),
          const SizedBox(height: 16),
          if (floatingButtonIcon2 != null && floatingButtonAction2 != null)
            FloatingActionButton(
              onPressed: floatingButtonAction2,
              child: Icon(floatingButtonIcon2),
            ),
        ],
      ),
    );
  }
}
