import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220512/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia_220512/infrastructure/repositories/movie_repository_impl.dart';

/// Provider que proporciona una instancia del repositorio de películas.
///
/// Configura la inyección de dependencias conectando el repositorio
/// con su datasource correspondiente (TheMovieDB API).
///
// Provider inmutable que mantiene una sola instancia del repositorio
// para toda la aplicación - evita crear múltiples instancias innecesarias
final movieRepositoryProvider = Provider((ref) {
  /// Crea instancia del repositorio inyectando el datasource de TheMovieDB
  /// Esta configuración conecta toda la cadena: UI -> Repository -> Datasource -> API
  // Aquí se conecta la implementación concreta con el datasource de MovieDB
  // Retorna MovieRepositoryImpl que implementa la interfaz MovieRepository
  return MovieRepositoryImpl(MoviedbDataSource());
});
