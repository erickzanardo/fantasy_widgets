import 'package:flutter/material.dart';
import 'fantasy_label.dart';

class FantasyBullet extends StatefulWidget {
  final IconData icon;
  final FantasyLabelStyle style;
  final bool visible;
  final Duration blinkInterval;

  FantasyBullet(
    this.icon, {
    this.style = const FantasyLabelStyle(),
    this.visible = true,
    this.blinkInterval,
  });

  @override
  State createState() => _FantasyBulletState();
}

class _FantasyBulletState extends State<FantasyBullet>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool _blinkStep = false;

  void _toggleBlink() {
    setState(() {
      _blinkStep = !_blinkStep;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.blinkInterval != null) {
      controller = AnimationController(
        vsync: this,
        duration: widget.blinkInterval,
      )
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.reverse();
            _toggleBlink();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
            _toggleBlink();
          }
        })
        ..forward();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(ctx) {
    return SizedBox(
      width: widget.style.size,
      height: widget.style.size,
      child: !_blinkStep && widget.visible
          ? Icon(widget.icon, color: widget.style.color)
          : null,
    );
  }
}
