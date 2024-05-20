import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';

class ChevronTabBar extends StatelessWidget {
  final List<String> items;
  final int activeIndex;
  final void Function(int index)? onActiveIndexChange;

  const ChevronTabBar({
    super.key,
    this.items = const [],
    required this.activeIndex,
    this.onActiveIndexChange,
  }):assert(activeIndex > -1 && activeIndex < items.length);

  @override
  Widget build(BuildContext context) {

    handleNext(){
      if(activeIndex == items.length -1){
        onActiveIndexChange!(0);
      }else{
        onActiveIndexChange!(activeIndex + 1);
      }
    }
    handlePrevious(){
      if(activeIndex == 0){
        onActiveIndexChange!(items.length -1);
      }else{
        onActiveIndexChange!(activeIndex - 1);
      }
    }

    final theme = Theme.of(context);
    final controlsActive = items.length > 1 && onActiveIndexChange != null;
    return Padding(
      padding: const EdgeInsets.all(Constants.SPACING),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: controlsActive ? theme.colorScheme.primary : null,
            ),
            onPressed: controlsActive ? handlePrevious : null,
          ),
          Expanded(
            child: Text(
              items[activeIndex],
              style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: controlsActive ? theme.colorScheme.primary : null,
            ),
            onPressed: controlsActive  ? handleNext : null,
          ),
        ],
      ),
    );
  }
}
