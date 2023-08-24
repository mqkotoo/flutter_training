import 'package:flutter/material.dart';

mixin AfterDisplayMixin<T extends StatefulWidget> on State<T> {
  void afterDisplay();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      afterDisplay();
    });
  }
}
