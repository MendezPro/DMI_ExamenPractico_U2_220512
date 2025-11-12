import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider simple que mantiene el loading por 17 segundos mínimo
/// NOTA: El control del loading ahora se maneja directamente en HomeScreen
final initialLoadingProvider = Provider<bool>((ref) {
  return true;
});
