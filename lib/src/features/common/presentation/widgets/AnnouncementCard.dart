import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class AnnouncementCard extends StatelessWidget {
  final String image;
  final String source;
  final String title;
  final String? description;
  final double? width;

  const AnnouncementCard({
    Key? key,
    required this.image,
    required this.source,
    required this.title,
    this.description,
    this.width = 100
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: (){},
      child: SizedBox(
        width: width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    if (description != null)
                      Text(
                        description!,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, ),

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
