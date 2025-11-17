import 'package:go_router/go_router.dart';
import 'package:cinemapedia_220512/presentation/screens/screens.dart';

/// Configuración principal de navegación de la aplicación.
///
/// Define todas las rutas disponibles usando GoRouter para navegación declarativa.
/// Permite navegar entre pantallas de forma programática y mediante URLs.
///
/// **Rutas disponibles:**
/// - `/` - Pantalla principal (HomeScreen)
///
final appRouter = GoRouter(
  // Ruta inicial que se muestra al abrir la aplicación
  initialLocation: '/',

  /// Lista de todas las rutas configuradas en la app
  routes: [
    /// Ruta Splash Screen - Primera pantalla con animación y audio
    GoRoute(
      path: '/',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),

    /// Ruta principal - Muestra la lista de películas en cartelera
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),

    /// Ruta de Series - Muestra las series de televisión
    GoRoute(
      path: '/series',
      name: TvSeriesScreen.name,
      builder: (context, state) => const TvSeriesScreen(),
    ),
  ],
);
