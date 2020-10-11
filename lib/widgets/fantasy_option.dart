import 'package:flutter/material.dart';

import 'fantasy_label.dart';

class FantasyOption extends StatelessWidget {
  final bool selected;
  final FantasyLabelStyle labelStyle;
  final String label;

  const FantasyOption(this.label, {
    this.labelStyle = const FantasyLabelStyle(),
    this.selected = false,
  });

  @override
  Widget build(_) {
    return Row(
        children: [
          // TODO create bullet widget
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
    );
  }
}

