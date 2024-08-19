import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class CarouselCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final double? width;
  final double? height;
  final Widget destination; 

  const CarouselCard({
    super.key,
    required this.svgPath,
    required this.title,
    this.width,
    this.height,
    required this.destination,
    });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      clipBehaviour: Clip.antiAlias,
      svgImage: "assets/images/rect_bg.svg",
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Constants.periodPlanner.withOpacity(0.5),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.periodPlanner,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                              context: context, 
                              builder: (context) => FractionallySizedBox(
                                heightFactor: 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: destination,
                                  ),
                              ),
                              );
                      },
                      child: Text(
                        'Click Me',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right column with SVG image
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                svgPath,
                fit: BoxFit.scaleDown,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}