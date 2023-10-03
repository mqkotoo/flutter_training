import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

//初期状態は横画面判定になっているので縦画面に設定する
void setDisplayVertical({
  Size size = const Size(390, 844),
  required WidgetTester tester,
}) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
}

//デバイスサイズ設定の破棄
void teardownDeviceSize(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}
