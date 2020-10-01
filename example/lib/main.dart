import 'package:flutter/material.dart';
import 'package:dashbook/dashbook.dart';
import 'package:fantasy_widgets/fantasy_widgets.dart';

void main() {
  final dashbook = Dashbook();

  dashbook.storiesOf('FantasyContainer').decorator(CenterDecorator())
      ..add('default', (ctx) => FantasyContainer(
              width: ctx.numberProperty('width', 300),
              height: ctx.numberProperty('height', 300),
              decoration: FantasyContainerDecoration(
                  borderSize: ctx.numberProperty('border size', 20.0),
                  borderColor: ctx.colorProperty('border color', Color(0xFFe7e7e7)),
                  borderColorShadow: ctx.colorProperty('border color shadow', Color(0xFFa2a2a2)),
                  backgroundColor: ctx.colorProperty('background color', Color(0xFF3b5dc9)),
                  borderRadius: Radius.circular(ctx.numberProperty('border radius', 10)),
              ),
        ));

  runApp(dashbook);
}
