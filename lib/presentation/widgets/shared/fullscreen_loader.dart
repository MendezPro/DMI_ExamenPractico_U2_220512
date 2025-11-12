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
      {'message': 'Verificando conexión a internet', 'progress': 0.05},
      {'message': 'Estableciendo conexión segura', 'progress': 0.12},
      {'message': 'Conectando con TheMovieDB API', 'progress': 0.20},
      {'message': 'Autenticando credenciales', 'progress': 0.28},
      {'message': 'Validando permisos de acceso', 'progress': 0.35},
      {'message': 'Obteniendo películas en cartelera', 'progress': 0.45},
      {'message': 'Descargando imágenes de películas', 'progress': 0.55},
      {'message': 'Cargando próximos estrenos', 'progress': 0.65},
      {'message': 'Descargando películas mejor valoradas', 'progress': 0.73},
      {'message': 'Cargando películas mexicanas', 'progress': 0.82},
      {'message': 'Organizando catálogo completo', 'progress': 0.90},
      {'message': 'Preparando interfaz visual', 'progress': 0.96},
      {'message': '¡Todo listo! Bienvenido a CineVerse', 'progress': 1.0},
    ];

    // Duración de 1.2 segundos entre cada paso = aprox 16-17 segundos total
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
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
              'Bienvenido a CineVerse',
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

                return Column(
                  children: [
                    // Porcentaje grande y destacado con animación
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween(begin: 0, end: progress * 100),
                      builder: (context, value, child) {
                        return Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                            shadows: [
                              Shadow(
                                color: colors.primary.withOpacity(0.3),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Barra de progreso más grande
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        width: 350,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeInOut,
                                tween: Tween(begin: 0, end: progress),
                                builder: (context, value, child) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    minHeight: 18,
                                    backgroundColor: colors.secondary.withOpacity(0.2),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      colors.primary,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Indicadores de inicio y fin
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '0%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.secondary.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  '100%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.secondary.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
