import 'package:cinemapedia_220512/infrastructure/mappers/tv_series_mapper.dart';
import 'package:cinemapedia_220512/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia_220512/infrastructure/models/tvdb/tvdb_response.dart';
import 'package:cinemapedia_220512/config/constants/environment.dart';
import 'package:cinemapedia_220512/domain/entities/tv_series.dart';
import 'package:dio/dio.dart';

/// Implementación concreta del datasource que obtiene datos de series de TheMovieDB API.
/// 
/// Esta clase se encarga de realizar peticiones HTTP a la API de TheMovieDB
/// y convertir las respuestas JSON en entidades de dominio utilizables.
/// 
class TvdbDataSource extends TvSeriesDatasource {
  /// Cliente HTTP configurado para la API de TheMovieDB
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX',
    }
  ));

  @override
  Future<List<TvSeries>> getAiringToday({int page = 1}) async {
    final response = await dio.get('/tv/airing_today', queryParameters: {
      'page': page
    });
    final tvdbResponse = TvdbResponse.fromJson(response.data);

    final List<TvSeries> series = tvdbResponse.results
      .where((tvdb) => tvdb.posterPath != 'no-poster')
      .map((tvdb) => TvSeriesMapper.tvdbToEntity(tvdb))
      .toList();

    return series;
  }

  @override
  Future<List<TvSeries>> getOnTheAir({int page = 1}) async {
    final response = await dio.get('/tv/on_the_air', queryParameters: {
      'page': page
    });
    final tvdbResponse = TvdbResponse.fromJson(response.data);

    final List<TvSeries> series = tvdbResponse.results
      .where((tvdb) => tvdb.posterPath != 'no-poster')
      .map((tvdb) => TvSeriesMapper.tvdbToEntity(tvdb))
      .toList();

    return series;
  }

  @override
  Future<List<TvSeries>> getPopular({int page = 1}) async {
    final response = await dio.get('/tv/popular', queryParameters: {
      'page': page
    });
    final tvdbResponse = TvdbResponse.fromJson(response.data);

    final List<TvSeries> series = tvdbResponse.results
      .where((tvdb) => tvdb.posterPath != 'no-poster')
      .map((tvdb) => TvSeriesMapper.tvdbToEntity(tvdb))
      .toList();

    return series;
  }

  @override
  Future<List<TvSeries>> getTopRated({int page = 1}) async {
    final response = await dio.get('/tv/top_rated', queryParameters: {
      'page': page
    });
    final tvdbResponse = TvdbResponse.fromJson(response.data);

    final List<TvSeries> series = tvdbResponse.results
      .where((tvdb) => tvdb.posterPath != 'no-poster')
      .map((tvdb) => TvSeriesMapper.tvdbToEntity(tvdb))
      .toList();

    return series;
  }

  @override
  Future<List<TvSeries>> getMexicanSeries({int page = 1}) async {
    final response = await dio.get('/discover/tv', queryParameters: {
      'page': page,
      'with_origin_country': 'MX',
      'with_original_language': 'es',
      'sort_by': 'first_air_date.desc',
      'vote_count.gte': 5
    });
    final tvdbResponse = TvdbResponse.fromJson(response.data);

    final List<TvSeries> series = tvdbResponse.results
      .where((tvdb) => tvdb.posterPath != 'no-poster')
      .map((tvdb) => TvSeriesMapper.tvdbToEntity(tvdb))
      .toList();

    return series;
  }
}
