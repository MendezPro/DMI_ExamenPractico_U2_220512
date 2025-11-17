import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider que controla si ya se mostró el loading inicial de la app
/// Esto evita que el loading aparezca cada vez que navegas entre pantallas
class AppInitialLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void markAsLoaded() {
    state = true;
  }

  bool get hasLoaded => state;
}

final appInitialLoadingProvider = NotifierProvider<AppInitialLoadingNotifier, bool>(() {
  return AppInitialLoadingNotifier();
});
