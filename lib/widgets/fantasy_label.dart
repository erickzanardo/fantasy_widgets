import 'package:flutter/widgets.dart';

class FantasyLabelStyle {
  final double size;
  final String family;
  final Color color;

  const FantasyLabelStyle({
    this.size = 18,
    this.family,
    this.color = const Color(0xFFFFFFFF),
  });
}

class FantasyLabel extends StatelessWidget {
  final FantasyLabelStyle style;
  final String text;

  FantasyLabel(
    this.text, {
    this.style = const FantasyLabelStyle(),
  });

  @override
  Widget build(_) {
    return Text(
      text,
      style: TextStyle(
        color: style.color,
        fontFamily: style.family,
        fontSize: style.size,
      ),
    );
  }
}
