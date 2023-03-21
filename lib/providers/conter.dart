import 'package:flutter/material.dart';

class ConterState {
  int _value = 0;
  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(ConterState old) {
    return old._value != _value;
  }
}

class ConterProvider extends InheritedWidget {
  final ConterState state = ConterState();
  ConterProvider({super.key, required Widget child}) : super(child: child);

  static ConterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConterProvider>();
  }

  @override
  bool updateShouldNotify(covariant ConterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
