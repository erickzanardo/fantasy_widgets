import 'package:flutter/widgets.dart';
import 'fantasy_widget_theme.dart';

class FantasyContainerDecoration {
  final double borderSize;
  final Color borderColor;
  final Color borderColorShadow;
  final Radius borderRadius;
  final Color backgroundColor;

  const FantasyContainerDecoration({
    this.borderSize = 20.0,
    this.borderColor = const Color(0xFFe7e7e7),
    this.borderColorShadow = const Color(0xFFa2a2a2),
    this.backgroundColor = const Color(0xFF3b5dc9),
    this.borderRadius = const Radius.circular(10),
  });
}

class FantasyContainer extends StatelessWidget {
  final FantasyContainerDecoration decoration;
  final double width;
  final double height;
  final Widget child;

  FantasyContainer({
    this.decoration,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(ctx) {
    final _decoration = decoration ?? FantasyWidgetTheme.of(ctx).containerStyle;
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _FantasyContainerPainter(_decoration),
        child: Container(
          padding: EdgeInsets.all(_decoration.borderSize * 2),
          child: child,
        ),
      ),
    );
  }
}

class _FantasyContainerPainter extends CustomPainter {
  FantasyContainerDecoration decoration;

  _FantasyContainerPainter(this.decoration);

  @override
  bool shouldRepaint(_FantasyContainerPainter painter) =>
      decoration != painter.decoration;

  @override
  void paint(Canvas canvas, Size size) {
    final borderSize = decoration.borderSize;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(borderSize, borderSize, size.width - borderSize * 2,
          size.height - borderSize * 2),
      decoration.borderRadius,
    );

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = decoration.borderColor
        ..strokeWidth = decoration.borderSize
        ..style = PaintingStyle.stroke,
    );

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = decoration.borderColorShadow
        ..strokeWidth = decoration.borderSize / 2
        ..style = PaintingStyle.stroke,
    );

    canvas.drawRRect(rrect, Paint()..color = decoration.backgroundColor);
  }
}
