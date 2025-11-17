import 'package:cinemapedia_220512/domain/entities/tv_series.dart';

/// Contrato que define los métodos necesarios para obtener datos de series de TV.
///
/// Este datasource abstracto establece la interfaz que cualquier implementación
/// concreta debe seguir, sin importar de dónde provengan los datos (API, BD local, etc.)
///
/// **Propósito:**
/// - Define las operaciones de obtención de datos de series
/// - Abstracción que permite cambiar la fuente de datos sin afectar el dominio
/// - Parte de la arquitectura limpia (Clean Architecture)
///
abstract class TvSeriesDatasource {
  /// Obtiene las series que están actualmente al aire
  ///
  /// **Parámetros:**
  /// - [page]: Número de página para paginación (default: 1)
  ///
  /// **Retorna:** Lista de series en emisión actual
  Future<List<TvSeries>> getAiringToday({int page = 1});

  /// Obtiene las series que se emitirán próximamente
  ///
  /// **Parámetros:**
  /// - [page]: Número de página para paginación (default: 1)
  ///
  /// **Retorna:** Lista de series próximas a estrenar
  Future<List<TvSeries>> getOnTheAir({int page = 1});

  /// Obtiene las series más populares
  ///
  /// **Parámetros:**
  /// - [page]: Número de página para paginación (default: 1)
  ///
  /// **Retorna:** Lista de series ordenadas por popularidad
  Future<List<TvSeries>> getPopular({int page = 1});

  /// Obtiene las series mejor valoradas por los usuarios
  ///
  /// **Parámetros:**
  /// - [page]: Número de página para paginación (default: 1)
  ///
  /// **Retorna:** Lista de series ordenadas por calificación
  Future<List<TvSeries>> getTopRated({int page = 1});

  /// Obtiene series mexicanas
  ///
  /// **Parámetros:**
  /// - [page]: Número de página para paginación (default: 1)
  ///
  /// **Retorna:** Lista de series de producción mexicana ordenadas por fecha
  Future<List<TvSeries>> getMexicanSeries({int page = 1});
}
