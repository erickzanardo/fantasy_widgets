import 'package:flutter/widgets.dart';

import 'fantasy_container.dart';
import 'fantasy_label.dart';

class FantasyTheme {
  final FantasyContainerDecoration containerStyle;
  final FantasyLabelStyle labelStyle;
  final FantasyLabelStyle textStyle;

  const FantasyTheme({
    this.containerStyle = const FantasyContainerDecoration(),
    this.labelStyle = const FantasyLabelStyle(),
    this.textStyle = const FantasyLabelStyle(),
  });
}

class FantasyWidgetTheme extends InheritedWidget {
  final FantasyTheme theme;

  FantasyWidgetTheme({
    Key key,
    @required Widget child,
    this.theme = const FantasyTheme(),
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget old) => true;

  static FantasyTheme of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<FantasyWidgetTheme>();
    assert(widget != null, 'No FantasyWidgetTheme available on the tree');

    return widget.theme;
  }
}
