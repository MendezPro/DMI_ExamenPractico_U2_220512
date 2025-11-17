import 'package:cinemapedia_220512/domain/datasources/tv_series_datasource.dart';
import 'package:cinemapedia_220512/domain/entities/tv_series.dart';
import 'package:cinemapedia_220512/domain/repositories/tv_series_repository.dart';

/// Implementación del repositorio de series de TV.
///
/// Actúa como intermediario entre la capa de presentación y el datasource,
/// delegando las llamadas pero permitiendo agregar lógica adicional si es necesario.
///
class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesDatasource datasource;

  TvSeriesRepositoryImpl(this.datasource);

  @override
  Future<List<TvSeries>> getAiringToday({int page = 1}) {
    return datasource.getAiringToday(page: page);
  }

  @override
  Future<List<TvSeries>> getOnTheAir({int page = 1}) {
    return datasource.getOnTheAir(page: page);
  }

  @override
  Future<List<TvSeries>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<TvSeries>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<TvSeries>> getMexicanSeries({int page = 1}) {
    return datasource.getMexicanSeries(page: page);
  }
}
