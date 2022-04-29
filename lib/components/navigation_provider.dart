import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  bool _isCollapsed = false;
  bool get isCollaspsed => _isCollapsed;

  void toggleIsCollapsed() {
    _isCollapsed = !isCollaspsed;

    notifyListeners();
  }
}
