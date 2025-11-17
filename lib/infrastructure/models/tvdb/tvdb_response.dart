import 'package:cinemapedia_220512/infrastructure/models/tvdb/tv_series_tvdb.dart';

/// Respuesta completa de la API de TheMovieDB para series de TV.
///
/// Encapsula la respuesta paginada que incluye múltiples series
/// junto con metadatos de paginación.
///
class TvdbResponse {
  final Dates? dates;
  final int page;
  final List<TvSeriesTvdb> results;
  final int totalPages;
  final int totalResults;

  TvdbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  /// Crea una instancia desde el JSON de la respuesta de la API
  factory TvdbResponse.fromJson(Map<String, dynamic> json) => TvdbResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<TvSeriesTvdb>.from(
            json["results"].map((x) => TvSeriesTvdb.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  /// Convierte la instancia a JSON
  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

/// Fechas asociadas a ciertas consultas de la API (ej: now_playing)
class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
