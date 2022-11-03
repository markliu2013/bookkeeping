import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {

  final Function(String) onSelected;
  final String selected;
  final Map<String, String> items;

  PopupMenu({
    required this.onSelected,
    required this.selected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = defaultStyle!.copyWith(color: Theme.of(context).colorScheme.secondary);
    return PopupMenuButton<String>(
      onSelected: onSelected,
      icon: Icon(Icons.swap_vert),
      itemBuilder: (context) => items.entries.map((i) => PopupMenuItem(
        value: i.key,
        child: Text(i.value, style: selected == i.key ? activeStyle : defaultStyle),
      )).toList()
    );
  }

}