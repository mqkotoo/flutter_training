import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_state_notifier.g.dart';

@riverpod
class LoadingStateNotifier extends _$LoadingStateNotifier {
  @override
  bool build() => false;

  void show() => state = true;

  void hide() => state = false;
}
