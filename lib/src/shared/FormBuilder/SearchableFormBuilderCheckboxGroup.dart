// /import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
//
// class SearchableDropdown extends StatefulWidget {
//   final String name;
//   final List<FormBuilderFieldOption> options;
//   final List<String> initialValue;
//   final InputDecoration decoration;
//
//   const SearchableDropdown({
//     Key? key,
//     required this.name,
//     required this.options,
//     this.initialValue = const [],
//     required this.decoration,
//   }) : super(key: key);
//
//   @override
//   _SearchableDropdownState createState() => _SearchableDropdownState();
// }
//
// class _SearchableDropdownState extends State<SearchableDropdown> {
//   List<String> _selectedValues = [];
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     _selectedValues = List.from(widget.initialValue);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             prefixIcon: Icon(Icons.search),
//             hintText: 'Search...',
//           ),
//           onChanged: (value) {
//             setState(() {});
//           },
//         ),
//         SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: widget.options
//               .where((option) =>
//               _getLabelText(option.child).toLowerCase().contains(_searchController.text.toLowerCase()))
//               .map((option) {
//             bool isSelected = _selectedValues.contains(option.value);
//             String labelText = _getLabelText(option.child);
//             return FilterChip(
//               label: Text(labelText),
//               selected: isSelected,
//               onSelected: (selected) {
//                 setState(() {
//                   if (selected) {
//                     _selectedValues.add(option.value);
//                   } else {
//                     _selectedValues.remove(option.value);
//                   }
//                 });
//               },
//               selectedColor: Theme.of(context).cardColor,
//               backgroundColor: Colors.grey[300],
//               checkmarkColor: Colors.white,
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   String _getLabelText(Widget? child) {
//     if (child is Text) {
//       return child.data ?? '';
//     } else {
//       return '';
//     }
//   }
// }
