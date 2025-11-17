/// Entidad que representa una serie de televisión en el dominio de la aplicación.
/// 
/// Esta clase define la estructura de datos de una serie de TV que usa
/// la lógica de negocio, independiente de cómo se almacene o se obtenga.
/// 
/// **Propósito:**
/// - Modelo de datos puro sin dependencias externas
/// - Representa el concepto de "serie de TV" en el negocio
/// - Usado por toda la aplicación de forma consistente
///
class TvSeries {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;

  TvSeries({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
    this.numberOfSeasons,
    this.numberOfEpisodes,
  });
}
