import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/logger.dart';

class LoggerWidget extends StatefulWidget {
  final String heading;
  final List<Logger> items;

  LoggerWidget({required this.heading, required this.items});

  @override
  _LoggerWidgetState createState() => _LoggerWidgetState();
}

class _LoggerWidgetState extends State<LoggerWidget> {
  // Create a list to keep track of the selected items
  late List<bool> _selectedItems;

  @override
  void initState() {
    super.initState();
    // Initialize the list with false (none of the items are selected initially)
    _selectedItems = List<bool>.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.heading,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.items
                .asMap()
                .entries
                .map((entry) => _buildItemCard(entry.key, entry.value))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(int index, Logger item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItems[index] = !_selectedItems[index];
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(item.icon, size: 40, color: item.color),
                if (_selectedItems[index])
                  Icon(Icons.check_circle, size: 40, color: Colors.green.withOpacity(0.9)),
              ],
            ),
            const SizedBox(height: 8),
              Text(item.label), 
          ],
        ),
      ),
    );
  }
}
