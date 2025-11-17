import 'package:cinemapedia_220512/domain/entities/tv_series.dart';
import 'package:cinemapedia_220512/infrastructure/models/tvdb/tv_series_tvdb.dart';

/// Mapper que convierte entre el modelo de la API y la entidad de dominio.
///
/// **Responsabilidades:**
/// - Transformar datos de TMDB a entidades de dominio
/// - Manejar campos opcionales y valores por defecto
/// - Construir URLs completas de imágenes
///
class TvSeriesMapper {
  /// Convierte un modelo de TMDB a una entidad de dominio
  static TvSeries tvdbToEntity(TvSeriesTvdb tvdb) => TvSeries(
        adult: tvdb.adult,
        backdropPath: (tvdb.backdropPath != '' && tvdb.backdropPath != null)
            ? 'https://image.tmdb.org/t/p/w500${tvdb.backdropPath}'
            : 'https://placehold.co/600x400/png?text=No+Image',
        genreIds: tvdb.genreIds,
        id: tvdb.id,
        originalLanguage: tvdb.originalLanguage,
        originalName: tvdb.originalName,
        overview: tvdb.overview,
        popularity: tvdb.popularity,
        posterPath: (tvdb.posterPath != '' && tvdb.posterPath != null)
            ? 'https://image.tmdb.org/t/p/w500${tvdb.posterPath}'
            : 'no-poster',
        firstAirDate: _parseDate(tvdb.firstAirDate),
        name: tvdb.name,
        voteAverage: tvdb.voteAverage,
        voteCount: tvdb.voteCount,
        originCountry: tvdb.originCountry,
      );

  /// Parsea la fecha de estreno con manejo de errores
  static DateTime _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return DateTime.now();
    }
  }
}
