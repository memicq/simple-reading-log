import 'package:flutter/material.dart';
import 'package:simple_book_log/bloc/event/tab_controller_event.dart';
import 'package:simple_book_log/widget/component/common/bottom_tab_item.dart';

class TabPage {
  late bool isActive;
  late TabControllerEvent openEvent;
  late BottomTabItem menuItem;
  late StatelessWidget content;

  TabPage({
    this.isActive = false,
    required this.openEvent,
    required this.menuItem,
    required this.content,
  });

  TabPage update(bool isActive, Function() onPressed) {
    return TabPage(
      isActive: isActive,
      openEvent: openEvent,
      menuItem: BottomTabItem(
        isActive: isActive,
        iconData: menuItem.iconData,
        filledIconData: menuItem.filledIconData,
        menuTitle: menuItem.menuTitle,
        onPressed: onPressed,
      ),
      content: content,
    );
  }
}
