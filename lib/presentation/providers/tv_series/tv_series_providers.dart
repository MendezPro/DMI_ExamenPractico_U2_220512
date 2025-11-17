import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220512/domain/entities/tv_series.dart';
import 'package:cinemapedia_220512/presentation/providers/tv_series/tv_series_repository_provider.dart';

/// Tipo de función callback para obtener series
typedef TvSeriesCallback = Future<List<TvSeries>> Function({int page});

/// Provider para series actualmente al aire
final airingTodaySeriesProvider =
    NotifierProvider<TvSeriesNotifier, List<TvSeries>>(
      () => TvSeriesNotifier((ref) => ref.watch(tvSeriesRepositoryProvider).getAiringToday),
    );

/// Provider para series que se emitirán próximamente
final onTheAirSeriesProvider =
    NotifierProvider<TvSeriesNotifier, List<TvSeries>>(
      () => TvSeriesNotifier((ref) => ref.watch(tvSeriesRepositoryProvider).getOnTheAir),
    );

/// Provider para series populares
final popularSeriesProvider =
    NotifierProvider<TvSeriesNotifier, List<TvSeries>>(
      () => TvSeriesNotifier((ref) => ref.watch(tvSeriesRepositoryProvider).getPopular),
    );

/// Provider para series mejor valoradas
final topRatedSeriesProvider =
    NotifierProvider<TvSeriesNotifier, List<TvSeries>>(
      () => TvSeriesNotifier((ref) => ref.watch(tvSeriesRepositoryProvider).getTopRated),
    );

/// Provider para series mexicanas
final mexicanSeriesProvider =
    NotifierProvider<TvSeriesNotifier, List<TvSeries>>(
      () => TvSeriesNotifier((ref) => ref.watch(tvSeriesRepositoryProvider).getMexicanSeries),
    );

/// Notifier que maneja el estado de las series con paginación infinita
class TvSeriesNotifier extends Notifier<List<TvSeries>> {
  final TvSeriesCallback Function(Ref ref) _callbackBuilder;
  late final TvSeriesCallback fetchMoreSeries;
  int currentPage = 0;
  bool isLoading = false;

  TvSeriesNotifier(this._callbackBuilder);

  @override
  List<TvSeries> build() {
    fetchMoreSeries = _callbackBuilder(ref);
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final series = await fetchMoreSeries(page: currentPage);

    state = [...state, ...series];

    isLoading = false;
  }
}
