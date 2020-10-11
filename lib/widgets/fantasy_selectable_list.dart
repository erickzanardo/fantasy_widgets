import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import './fantasy_container.dart';
import './fantasy_option.dart';
import './fantasy_label.dart';

class FantasySelectableList extends StatefulWidget {

  final FantasyContainerDecoration decoration;
  final FantasyLabelStyle optionStyle;
  final List<String> options;
  final int initialItem;
  final double width;
  final double height;

  FantasySelectableList({
    this.width,
    this.height,
    this.decoration = const FantasyContainerDecoration(),
    this.optionStyle = const FantasyLabelStyle(),
    this.options = const [],
    this.initialItem,
  });

  @override
  State createState() => _FantasySelectableList();
}

class _FantasySelectableList extends State<FantasySelectableList> {
  String _currentItem;

  @override
  void initState() {
    super.initState();

    if (widget.initialItem != null && widget.initialItem < widget.options.length) {
      _currentItem = widget.options[widget.initialItem];
    }

    RawKeyboard.instance.addListener(_onKey);
  }

  @override
  void dispose() {
    super.dispose();
    RawKeyboard.instance.removeListener(_onKey);
  }

  int _currentIndex() {
    if (_currentItem == null)
      return 0;

    return widget.options.indexOf(_currentItem);
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      final i = _currentIndex();
      String nextOption;

      if (event.logicalKey.keyId == LogicalKeyboardKey.arrowUp.keyId || event.logicalKey.keyId == LogicalKeyboardKey.arrowDown.keyId) {
        if (event.logicalKey.keyId == LogicalKeyboardKey.arrowUp.keyId) {
          if (i == 0) {
            nextOption = widget.options.last;
          } else {
            nextOption = widget.options[i - 1];
          }
        } else if (event.logicalKey.keyId == LogicalKeyboardKey.arrowDown.keyId) {
          if (i == widget.options.length - 1) {
            nextOption = widget.options.first;
          } else {
            nextOption = widget.options[i + 1];
          }
        }
        setState(() {
          _currentItem = nextOption;
        });
      }
    }
  }

  @override
  Widget build(_) {
    return FantasyContainer(
        width: widget.width,
        height: widget.height,
        child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget
                .options?.map((option) => FantasyOption(
                        option,
                        selected: option == _currentItem,
                        labelStyle: widget.optionStyle,
                ))?.toList()
        )),
    );
  }
}
