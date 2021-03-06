import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fantasy_widgets/fantasy_widgets.dart';

class SaveMenuExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SaveMenuExampleState();
  }
}

class _SaveMenuExampleState extends State<SaveMenuExample> {
  bool _optionMenuOpen = false;
  bool _saveMenuOpen = false;
  bool _infoOpen = false;

  void _openMenu() {
    setState(() {
      _optionMenuOpen = true;
    });
  }

  void _hideMenu() {
    setState(() {
      _optionMenuOpen = false;
    });
  }

  void _openSaveMenu() {
    setState(() {
      _saveMenuOpen = true;
    });
  }

  void _hideSaveMenu() {
    setState(() {
      _saveMenuOpen = false;
    });
  }

  void _openInfo() {
    setState(() {
      _infoOpen = true;
    });
  }

  void _hideInfo() {
    setState(() {
      _infoOpen = false;
    });
  }

  void _keyEvent(RawKeyEvent event) {
    if (event is RawKeyUpEvent &&
        event.logicalKey.keyId == LogicalKeyboardKey.space.keyId &&
        !_optionMenuOpen) {
      _openMenu();
    }
  }

  @override
  void initState() {
    super.initState();

    RawKeyboard.instance.addListener(_keyEvent);
  }

  @override
  void dispose() {
    super.dispose();

    RawKeyboard.instance.removeListener(_keyEvent);
  }

  Widget _if(bool condition, Widget widget) => condition ? widget : Container();

  @override
  Widget build(ctx) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Color(0xFF000000),
            child: Center(
              child: GestureDetector(
                onTap: _openMenu,
                child: Text(
                  'Tap here, or press space to open menu',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: _if(
            _optionMenuOpen,
            FantasySelectableList(
              initialItem: 0,
              width: 280,
              height: 230,
              hasFocus: _optionMenuOpen && !_saveMenuOpen && !_infoOpen,
              onOptionSelect: (option) {
                if (option == 'Resume game') {
                  _hideMenu();
                } else if (option == 'Save') {
                  _openSaveMenu();
                }
              },
              options: [
                'Character',
                'Items',
                'Gear',
                'Quests',
                'Options',
                'Save',
                'Resume game',
              ],
            ),
          ),
        ),
        Positioned(
          top: 140,
          right: 260,
          child: _if(
            _saveMenuOpen,
            FantasySelectableList(
              title: 'Save your progress?',
              hasFocus: _saveMenuOpen && !_infoOpen,
              initialItem: 0,
              width: 280,
              height: 170,
              onOptionSelect: (option) {
                if (option == 'No') {
                  _hideMenu();
                  _hideSaveMenu();
                } else {
                  _openInfo();
                }
              },
              options: ['No', 'Yes'],
            ),
          ),
        ),
        Positioned.fill(
          child: _if(
              _infoOpen,
              Center(
                child: FantasyTextBox(
                  'Game Saved',
                  width: 220,
                  onClose: () {
                    _hideSaveMenu();
                    _hideMenu();
                    _hideInfo();
                  },
                ),
              )),
        ),
      ],
    );
  }
}
