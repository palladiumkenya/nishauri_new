import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nishauri/src/shared/display/Logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final painter = DottedLinePainter();
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            painter.paint(Canvas(PictureRecorder()),
                size); // Paint once to calculate positions

            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Logo(size: 78),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(43, 208, 191, 1),
                                  Color.fromRGBO(31, 92, 209, 1),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.0, 0.8],
                              ).createShader(bounds),
                              child: const Text(
                                "NISHAURI",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: 205.0,
                              height: 1,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color.fromRGBO(136, 216, 210, 1.0),
                                    Color.fromRGBO(31, 92, 209, 1.0),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              "YOUR HEALTH, YOUR PRIORITY\n START TODAY, THRIVE TOMORROW",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              width: 205.0,
                              height: 1.0,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color.fromRGBO(136, 216, 210, 1.0),
                                    Color.fromRGBO(31, 92, 209, 1.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const CircularProgressIndicator(
                      color: Color.fromARGB(255, 29, 134, 219),
                    ),
                  ],
                ),
                CustomPaint(
                  size: size,
                  painter: painter,
                  child: Container(),
                ),
                for (var i = 0; i < painter.iconPositions.length; i++)
                  Positioned(
                    top: painter.iconPositions[i].dy,
                    left: painter.iconPositions[i].dx,
                    child: SvgPicture.asset(
                      _getIconAsset(i),
                      height: 40,
                      color: const Color.fromARGB(255, 29, 134, 219),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _getIconAsset(int index) {
    switch (index) {
      case 0:
        return 'assets/images/Calling-Splash.svg';
      case 1:
        return 'assets/images/Home-Splash.svg';
      case 2:
        return 'assets/images/Pills-Splash.svg';
      case 3:
        return 'assets/images/Location-Splash.svg';
      case 4:
        return 'assets/images/Heart-Splash.svg';
      case 5:
        return 'assets/images/Calendar-Splash.svg';
      default:
        return '';
    }
  }
}

class DottedLinePainter extends CustomPainter {
  final List<Offset> iconPositions = [];

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(116, 33, 149, 243)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();

    // Phone Icon Path
    path.moveTo(size.width / 2, size.height * 0.4);
    path.lineTo(size.width / 2, size.height * 0.23);
    path.lineTo(size.width / 3, size.height * 0.23);
    path.lineTo(size.width / 3, size.height * 0.07);
    path.lineTo(size.width / 2.2, size.height * 0.07);
    iconPositions.add(Offset(
        size.width / 2.25, (size.height * 0.07) * 0.63)); // Phone Icon Position

    // Home Icon Path
    path.moveTo(size.width / 3, size.height * 0.4);
    path.lineTo(size.width / 3, size.height * 0.28);
    path.lineTo((size.width / 3.8), size.height * 0.28);
    iconPositions.add(Offset((size.width / 3.8) * 0.63,
        (size.height * 0.28) * 0.92)); // Home Icon Position

    // Pill Icon Path
    path.moveTo(size.width / 1.5, size.height * 0.4);
    path.lineTo(size.width / 1.5, size.height * 0.20);
    iconPositions.add(Offset((size.width / 1.5) * 0.93,
        (size.height * 0.20) * 0.7)); // Pill Icon Position

    // Location Icon Path
    path.moveTo(size.width / 2, size.height / 1.7);
    path.lineTo(size.width / 2, size.height / 1.2);
    path.lineTo(size.width / 2.5, size.height / 1.2);
    path.lineTo(size.width / 2.5, size.height / 1.13);
    iconPositions.add(Offset((size.width / 2.5) * 0.85,
        (size.height / 1.13) * 1)); // Location Icon Position

    // Heart Icon Path
    path.moveTo(size.width / 3, size.height / 1.7);
    path.lineTo(size.width / 3, size.height / 1.45);
    path.lineTo(size.width / 3.8, size.height / 1.45);
    path.lineTo(size.width / 3.8, size.height / 1.38);
    iconPositions.add(Offset((size.width / 3.8) * 0.79,
        (size.height / 1.38) * 1.01)); // Heart Icon Position

    // Calendar Icon Path
    path.moveTo(size.width / 1.5, size.height / 1.7);
    path.lineTo(size.width / 1.5, size.height / 1.45);
    path.lineTo(size.width / 1.15, size.height / 1.45);
    path.lineTo(size.width / 1.15, size.height / 1.16);
    path.lineTo(size.width / 1.35, size.height / 1.16);
    iconPositions.add(
      Offset(
        (size.width / 1.35) * 0.85,
        (size.height / 1.16) * 0.97,
      ),
    ); // Calendar Icon Position

    // Draw dashed lines
    double dashWidth = 5.0, dashSpace = 5.0, distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
            pathMetric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
      distance = 0.0; // Reset distance for the next path
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
