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
  Map<String, GlobalKey> _keys = {};

  @override
  void initState() {
    super.initState();

    if (widget.initialItem != null &&
        widget.initialItem < widget.options.length) {
      _currentItem = widget.options[widget.initialItem];
    }

    widget.options.forEach((option) {
      _keys[option] = GlobalKey();
    });

    RawKeyboard.instance.addListener(_onKey);
  }

  @override
  void dispose() {
    super.dispose();
    RawKeyboard.instance.removeListener(_onKey);
  }

  int _currentIndex() {
    if (_currentItem == null) return 0;

    return widget.options.indexOf(_currentItem);
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      final i = _currentIndex();
      String nextOption;

      if (event.logicalKey.keyId == LogicalKeyboardKey.arrowUp.keyId ||
          event.logicalKey.keyId == LogicalKeyboardKey.arrowDown.keyId) {
        if (event.logicalKey.keyId == LogicalKeyboardKey.arrowUp.keyId) {
          if (i == 0) {
            nextOption = widget.options.last;
          } else {
            nextOption = widget.options[i - 1];
          }
        } else if (event.logicalKey.keyId ==
            LogicalKeyboardKey.arrowDown.keyId) {
          if (i == widget.options.length - 1) {
            nextOption = widget.options.first;
          } else {
            nextOption = widget.options[i + 1];
          }
        }
        setState(() {
          _currentItem = nextOption;
          Scrollable.ensureVisible(
              _keys[_currentItem].currentContext,
          );
        });
      }
    }
  }

  @override
  Widget build(_) {
    return FantasyContainer(
      width: widget.width,
      height: widget.height,
      child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _keys.entries
                  .map(
                    (entry) => FantasyOption(
                      entry.key,
                      key: entry.value,
                      selected: entry.key == _currentItem,
                      labelStyle: widget.optionStyle,
                      onTap: () {
                        setState(() {
                          _currentItem = entry.key;
                        });
                      }
                    ),
                  )
                  ?.toList()),
      ),
    );
  }
}
