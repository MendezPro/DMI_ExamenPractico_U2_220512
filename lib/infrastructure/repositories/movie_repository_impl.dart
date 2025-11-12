import 'package:cinemapedia_220512/domain/repositories/movies_repository.dart';
import 'package:cinemapedia_220512/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_220512/domain/entities/movie.dart';

/// Implementación concreta del repositorio de películas.
///
/// Actúa como intermediario entre la capa de presentación y el datasource,
/// aplicando lógica de negocio si es necesaria antes de devolver los datos.
class MovieRepositoryImpl implements MoviesRepository {
  /// Datasource que se encarga del acceso real a los datos
  final MoviesDatasource datasource;

  /// Constructor que recibe el datasource por inyección de dependencias
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    /// Delega la operación al datasource
    /// Aquí se podría agregar lógica adicional como:
    /// - Validación de parámetros
    /// - Cache de resultados
    /// - Transformaciones de datos
    /// - Logging de operaciones
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getMexicanMovies({int page = 1}) {
    return datasource.getMexicanMovies(page: page);
  }

    @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }


}
