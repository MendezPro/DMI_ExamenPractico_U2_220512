import 'package:cinemapedia_220512/domain/entities/tv_series.dart';

/// Contrato del repositorio que define las operaciones de negocio para series de TV.
///
/// Este repositorio abstracto establece el contrato que la capa de presentación
/// usará para obtener series, sin conocer los detalles de implementación.
///
/// **Propósito:**
/// - Define las operaciones disponibles para la lógica de negocio
/// - Abstrae la fuente de datos real (puede venir de API, caché, BD local)
/// - Permite testing y mockeo fácil
///
abstract class TvSeriesRepository {
  /// Obtiene las series que están actualmente al aire
  Future<List<TvSeries>> getAiringToday({int page = 1});

  /// Obtiene las series que se emitirán próximamente
  Future<List<TvSeries>> getOnTheAir({int page = 1});

  /// Obtiene las series más populares
  Future<List<TvSeries>> getPopular({int page = 1});

  /// Obtiene las series mejor valoradas
  Future<List<TvSeries>> getTopRated({int page = 1});

  /// Obtiene series mexicanas ordenadas por fecha de estreno
  Future<List<TvSeries>> getMexicanSeries({int page = 1});
}
