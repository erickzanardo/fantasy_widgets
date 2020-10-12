import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fantasy_container.dart';
import 'fantasy_label.dart';

class FantasyTextBox extends StatefulWidget {
  final double width;
  final double height;
  final FantasyLabelStyle textStyle;
  final String text;
  final VoidCallback onClose;
  final LogicalKeyboardKey closeKey;

  FantasyTextBox(
    this.text, {
    this.width,
    this.height,
    this.textStyle = const FantasyLabelStyle(),
    this.onClose,
    this.closeKey = LogicalKeyboardKey.space,
  });

  @override
  State<StatefulWidget> createState() {
    return _FantasyTextBoxState();
  }
}

class _FantasyTextBoxState extends State<FantasyTextBox> {
  @override
  void initState() {
    super.initState();

    RawKeyboard.instance.addListener(_handleEvent);
  }

  @override
  void dispose() {
    super.dispose();

    RawKeyboard.instance.removeListener(_handleEvent);
  }

  void _handleEvent(RawKeyEvent event) {
    if (event is RawKeyUpEvent && event.logicalKey.keyId == widget.closeKey.keyId) {
      widget.onClose?.call();
    }
  }

  @override
  Widget build(_) {
    return FantasyContainer(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          FantasyLabel(
            widget.text,
            style: widget.textStyle,
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                  child: Icon(
                      Icons.arrow_drop_down,
                      size: widget.textStyle.size,
                      color: widget.textStyle.color,
                  ),
              ),
          ),
        ],
      ),
    );
  }
}
