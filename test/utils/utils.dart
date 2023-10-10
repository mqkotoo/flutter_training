import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

final binding = TestWidgetsFlutterBinding.ensureInitialized();

//初期状態は横画面判定になっているので縦画面に設定する
void setDisplayVertical({
  Size size = const Size(390, 844),
}) {
  binding.platformDispatcher.implicitView!.physicalSize = size;
  binding.platformDispatcher.implicitView!.devicePixelRatio = 1;
}

//デバイスサイズ設定の破棄
void teardownDeviceSize() {
  binding.platformDispatcher.implicitView!.resetPhysicalSize();
  binding.platformDispatcher.implicitView!.resetDevicePixelRatio();
}
