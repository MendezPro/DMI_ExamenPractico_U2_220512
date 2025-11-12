import 'package:flutter/material.dart';

/// Loading Screen progresivo que muestra porcentaje de carga
///
/// **Funcionalidades:**
/// - Muestra porcentaje de 0% a 100%
/// - Barra de progreso animada
/// - Mensajes de carga sincronizados con el porcentaje
/// - Diseño moderno y atractivo
class FullscreenLoader extends StatelessWidget {
  const FullscreenLoader({super.key});

  /// Stream que emite mensajes de carga con su porcentaje asociado
  Stream<Map<String, dynamic>> getLoadingProgress() {
    final progressSteps = [
      {'message': 'Iniciando CineVerse...', 'progress': 0.0},
      {'message': 'Estableciendo conexión segura', 'progress': 0.10},
      {'message': 'Conectando con TheMovieDB API', 'progress': 0.25},
      {'message': 'Autenticando credenciales', 'progress': 0.35},
      {'message': 'Obteniendo películas en cartelera', 'progress': 0.50},
      {'message': 'Cargando próximos estrenos', 'progress': 0.65},
      {'message': 'Descargando películas mejor valoradas', 'progress': 0.78},
      {'message': 'Cargando películas mexicanas', 'progress': 0.88},
      {'message': 'Preparando interfaz visual', 'progress': 0.95},
      {'message': '¡Todo listo! Bienvenido', 'progress': 1.0},
    ];

    return Stream.periodic(const Duration(milliseconds: 800), (step) {
      if (step < progressSteps.length) {
        return progressSteps[step];
      }
      return progressSteps.last;
    }).take(progressSteps.length);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.primary.withOpacity(0.1),
            colors.secondary.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o ícono
            Icon(
              Icons.movie_creation_outlined,
              size: 80,
              color: colors.primary,
            ),
            const SizedBox(height: 20),
            
            // Título
            Text(
              'Bienvenido a Cinemapedia',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 10),
            
            Text(
              'Matrícula: 220512',
              style: TextStyle(
                fontSize: 14,
                color: colors.secondary,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // StreamBuilder para mostrar progreso dinámico
            StreamBuilder<Map<String, dynamic>>(
              stream: getLoadingProgress(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      const CircularProgressIndicator(strokeWidth: 4),
                      const SizedBox(height: 20),
                      Text(
                        'Iniciando...',
                        style: TextStyle(color: colors.secondary),
                      ),
                    ],
                  );
                }

                final data = snapshot.data!;
                final progress = data['progress'] as double;
                final message = data['message'] as String;
                final percentage = (progress * 100).toInt();

                return Column(
                  children: [
                    // Porcentaje grande y destacado
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Barra de progreso
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 12,
                            backgroundColor: colors.secondary.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Mensaje de carga
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: colors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
