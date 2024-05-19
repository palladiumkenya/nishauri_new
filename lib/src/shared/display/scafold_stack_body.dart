import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/helpers.dart';

class ScaffoldStackedBody extends StatelessWidget {
  final Widget body;

  const ScaffoldStackedBody({super.key, required this.body});

  factory ScaffoldStackedBody.withSafeArea(Widget body) {
    return ScaffoldStackedBody(
      body: SafeArea(
        child: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = getOrientationAwareScreenSize(context);

    return Stack(
      children: [
        Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/images/rect-bg.svg",
              semanticsLabel: "Doctors",
              fit: BoxFit.contain,
              height: size.width * 0.55,
              width: size.width * 0.55,
            )),
        SafeArea(
          child: body,
        ),
      ],
    );
  }
}
