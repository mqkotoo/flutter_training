import 'package:flutter/material.dart';

@immutable
class ErrorMessage {
  const ErrorMessage._();

  static const invalidParameter = 'パラメータが有効ではありません。';
  static const unknown = '予期せぬエラーが発生しました。';
  static const receiveInvalidData = '不適切なデータを取得しました。';
}
