import 'package:flutter/material.dart';

class DropDownListTile<T> extends StatefulWidget {

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T? value) onChanged;
  const DropDownListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.items,
    this.leading,
    this.subtitle,
    super.key,});

  @override
  State<DropDownListTile<T>> createState() => _DropDownListTileState<T>();
}

class _DropDownListTileState<T> extends State<DropDownListTile<T>> {
  final focusNode = FocusNode();


  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListTile(
    title: widget.title,
    subtitle: widget.subtitle,
    leading: widget.leading,
    onTap: focusNode.requestFocus,
    trailing: DropdownButton<T>(
      focusNode: focusNode,
      value: widget.value,
      items: widget.items,
      onChanged: widget.onChanged,
    ),
  );
}