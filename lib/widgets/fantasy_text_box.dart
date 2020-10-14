import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fantasy_container.dart';
import 'fantasy_label.dart';
import 'fantasy_bullet.dart';

class FantasyTextBox extends StatefulWidget {
  final double width;
  final double height;
  final FantasyLabelStyle textStyle;
  final String text;
  final VoidCallback onClose;
  final LogicalKeyboardKey closeKey;
  final Duration wordStepTime;

  FantasyTextBox(
    this.text, {
    this.width,
    this.height,
    this.textStyle = const FantasyLabelStyle(),
    this.onClose,
    this.closeKey = LogicalKeyboardKey.space,
    this.wordStepTime = const Duration(milliseconds: 200),
  });

  @override
  State<StatefulWidget> createState() {
    return _FantasyTextBoxState();
  }
}

class _FantasyTextBoxState extends State<FantasyTextBox>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  List<String> _textQueue;
  String _text;
  bool _finished;

  @override
  void initState() {
    super.initState();

    if (widget.wordStepTime != null) {
      _finished = false;
      _text = "";
      _textQueue = widget.text.split(' ');

      controller = AnimationController(
        vsync: this,
        duration: widget.wordStepTime,
      )
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.reverse();
            _tick();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
            _tick();
          }
        })
        ..forward();
    } else {
      _finished = true;
      _text = widget.text;
    }

    RawKeyboard.instance.addListener(_handleEvent);
  }

  @override
  void dispose() {
    super.dispose();

    RawKeyboard.instance.removeListener(_handleEvent);
  }

  void _tick() {
    if (_textQueue.isEmpty) {
      setState(() {
        _finished = true;
        controller.stop();
      });
    } else {
      setState(() {
        _text = '$_text ${_textQueue.removeAt(0)}';
      });
    }
  }

  void _handleEvent(RawKeyEvent event) {
    if (_finished &&
        event is RawKeyUpEvent &&
        event.logicalKey.keyId == widget.closeKey.keyId) {
      widget.onClose?.call();
    }
  }

  @override
  Widget build(_) {
    return GestureDetector(
      onTap: () {
        if (_finished) {
          widget.onClose?.call();
        }
      },
      child: FantasyContainer(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            FantasyLabel(
              _text,
              style: widget.textStyle,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: _finished
                  ? FantasyBullet(
                      Icons.arrow_drop_down,
                      blinkInterval: Duration(seconds: 1),
                      style: widget.textStyle,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
