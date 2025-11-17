import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220512/domain/entities/tv_series.dart';
import 'package:cinemapedia_220512/presentation/providers/tv_series/tv_series_providers.dart';

/// Provider que proporciona las series para el slideshow (Top 10)
///
/// Toma las primeras 6 series de las mejor valoradas para mostrarlas
/// en el carrusel principal de la pantalla de series.
///
final tvSeriesSlideshowProvider = Provider<List<TvSeries>>((ref) {
  final topRatedSeries = ref.watch(topRatedSeriesProvider);

  if (topRatedSeries.isEmpty) return [];

  // Retorna las primeras 6 series para el slideshow
  return topRatedSeries.sublist(0, topRatedSeries.length > 6 ? 6 : topRatedSeries.length);
});
