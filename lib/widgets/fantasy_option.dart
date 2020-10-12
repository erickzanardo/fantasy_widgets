import 'package:flutter/material.dart';

import 'fantasy_label.dart';

class FantasyOption extends StatelessWidget {
  final Key key;
  final bool selected;
  final FantasyLabelStyle labelStyle;
  final String label;
  final VoidCallback onTap;

  const FantasyOption(
    this.label, {
    this.key,
    this.labelStyle = const FantasyLabelStyle(),
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(_) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Row(
        children: [
          SizedBox(
            width: labelStyle.size,
            height: labelStyle.size,
            child: selected
                ? Icon(Icons.play_arrow, color: labelStyle.color)
                : null,
          ),
          SizedBox(width: 10),
          FantasyLabel(label, style: labelStyle),
        ],
      ),
    );
  }
}
