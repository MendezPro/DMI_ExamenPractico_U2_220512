import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220512/domain/repositories/tv_series_repository.dart';
import 'package:cinemapedia_220512/infrastructure/datasources/tvdb_datasource.dart';
import 'package:cinemapedia_220512/infrastructure/repositories/tv_series_repository_impl.dart';

/// Provider inmutable que proporciona el repositorio de series de TV.
///
/// Este provider crea una única instancia del repositorio configurado
/// con el datasource de TheMovieDB.
///
final tvSeriesRepositoryProvider = Provider<TvSeriesRepository>((ref) {
  return TvSeriesRepositoryImpl(TvdbDataSource());
});
