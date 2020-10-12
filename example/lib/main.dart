import 'package:flutter/material.dart';
import 'package:dashbook/dashbook.dart';
import 'package:fantasy_widgets/fantasy_widgets.dart';

import './save_menu_example.dart';

void main() {
  final dashbook = Dashbook();

  dashbook.storiesOf('Examples').decorator(CenterDecorator())
    ..add('save menu', (_) => SaveMenuExample());

  dashbook.storiesOf('FantasyTextBox').decorator(CenterDecorator())
    ..add(
      'default',
      (ctx) => FantasyTextBox(
        ctx.textProperty('Text', 'Fantasy widgets is cool'),
        width: ctx.numberProperty('width', 400),
        height: ctx.numberProperty('height', 200),
      ),
    );

  dashbook.storiesOf('FantasySelectableList').decorator(CenterDecorator())
    ..add(
        'default',
        (ctx) => FantasySelectableList(
              width: ctx.numberProperty('width', 300),
              height: ctx.numberProperty('height', 400),
              initialItem: 0,
              options: [
                'Characters',
                'Quest',
                'Items',
                'Magic',
                'Gear',
                'Quests',
                'Options',
                'Save',
              ],
            ));

  dashbook.storiesOf('FantasyContainer').decorator(CenterDecorator())
    ..add(
        'default',
        (ctx) => FantasyContainer(
              width: ctx.numberProperty('width', 300),
              height: ctx.numberProperty('height', 300),
              decoration: FantasyContainerDecoration(
                borderSize: ctx.numberProperty('border size', 20.0),
                borderColor:
                    ctx.colorProperty('border color', Color(0xFFe7e7e7)),
                borderColorShadow:
                    ctx.colorProperty('border color shadow', Color(0xFFa2a2a2)),
                backgroundColor:
                    ctx.colorProperty('background color', Color(0xFF3b5dc9)),
                borderRadius:
                    Radius.circular(ctx.numberProperty('border radius', 10)),
              ),
            ));

  runApp(dashbook);
}
