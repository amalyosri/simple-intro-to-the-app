import 'package:flutter/material.dart';

class Mycolor extends InheritedWidget {
  final Color color;
  final Widget child;

  Mycolor({Key? key, required this.color, required this.child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant Mycolor oldWidget) {
    // TODO: implement updateShouldNotify
    return color != oldWidget.color;
  }

  static Mycolor of(context) =>
      context.dependOnInheritedWidgetOfExactType<Mycolor>();
}
