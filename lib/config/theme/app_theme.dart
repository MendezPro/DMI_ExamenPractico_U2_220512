import 'package:flutter/material.dart';

/// Configuración del tema visual de la aplicación.
/// 
/// Define los colores, estilos y apariencia general que se aplicarán
/// en toda la aplicación de forma consistente.
/// 

class AppTheme {
  /// Genera y retorna el tema completo de la aplicación.
  /// Configura Material Design 3 con un esquema de colores basado
  /// en el color semilla azul para mantener consistencia visual.
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF2862F5),
  );
}