import 'package:cinemapedia_220512/presentation/providers/tv_series/tv_series_providers.dart';
import 'package:cinemapedia_220512/presentation/providers/tv_series/tv_series_slideshow_provider.dart';
import 'package:cinemapedia_220512/presentation/providers/movies/initialLoanding_provider.dart';
import 'package:cinemapedia_220512/presentation/widgets/tv_series/tv_series_horizontal_listview.dart';
import 'package:cinemapedia_220512/presentation/widgets/tv_series/tv_series_slidershow.dart';
import 'package:cinemapedia_220512/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia_220512/presentation/widgets/shared/custom_button_navigationbar.dart';
import 'package:cinemapedia_220512/presentation/widgets/shared/fullscreen_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Pantalla principal de series de TV que muestra diferentes categorías.
///
/// **Secciones:**
/// - Top 10 en Swiper
/// - Series Actuales (Airing Today)
/// - Por Estrenarse (On The Air)
/// - Series Populares
/// - Series Mejor Valoradas
/// - Series Mexicanas
class TvSeriesScreen extends StatelessWidget {
  static const name = 'tv-series-screen';

  const TvSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _TvSeriesView(),
      bottomNavigationBar: CustomButtonNavigationbar(currentIndex: 1),
    );
  }
}

/// Vista interna que maneja el estado y la lógica de la pantalla.
class _TvSeriesView extends ConsumerStatefulWidget {
  const _TvSeriesView();

  @override
  _TvSeriesViewState createState() => _TvSeriesViewState();
}

class _TvSeriesViewState extends ConsumerState<_TvSeriesView> {
  bool _isLoading = true;
  bool _minTimeElapsed = false;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null);

    // Verificar si ya se mostró el loading inicial
    final hasLoadedBefore = ref.read(appInitialLoadingProvider);

    // Cargar datos de todas las categorías
    ref.read(airingTodaySeriesProvider.notifier).loadNextPage();
    ref.read(onTheAirSeriesProvider.notifier).loadNextPage();
    ref.read(popularSeriesProvider.notifier).loadNextPage();
    ref.read(topRatedSeriesProvider.notifier).loadNextPage();
    ref.read(mexicanSeriesProvider.notifier).loadNextPage();

    // Si ya se cargó antes, no mostrar el loading de 17 segundos
    if (hasLoadedBefore) {
      setState(() {
        _minTimeElapsed = true;
        _isLoading = false;
      });
    } else {
      // Garantizar tiempo mínimo de 5 segundos solo la primera vez
      Future.delayed(const Duration(milliseconds: 5000), () {
        if (mounted) {
          setState(() {
            _minTimeElapsed = true;
            _checkLoadingComplete();
          });
        }
      });
    }

    // Verificar si los datos están cargados
    if (!hasLoadedBefore) {
      _checkDataLoading();
    }
  }

  void _checkDataLoading() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      final airingToday = ref.read(airingTodaySeriesProvider);
      final onTheAir = ref.read(onTheAirSeriesProvider);
      final popular = ref.read(popularSeriesProvider);
      final topRated = ref.read(topRatedSeriesProvider);
      final mexican = ref.read(mexicanSeriesProvider);

      if (airingToday.isNotEmpty &&
          onTheAir.isNotEmpty &&
          popular.isNotEmpty &&
          topRated.isNotEmpty &&
          mexican.isNotEmpty) {
        setState(() {
          _dataLoaded = true;
          _checkLoadingComplete();
        });
      } else {
        _checkDataLoading();
      }
    });
  }

  void _checkLoadingComplete() {
    if (_minTimeElapsed && _dataLoaded && _isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Obtiene el mes actual en español
  String get currentMonthName {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM', 'es_ES');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const FullscreenLoader();

    final slideshowSeries = ref.watch(tvSeriesSlideshowProvider);
    final airingToday = ref.watch(airingTodaySeriesProvider);
    final onTheAir = ref.watch(onTheAirSeriesProvider);
    final popular = ref.watch(popularSeriesProvider);
    final topRated = ref.watch(topRatedSeriesProvider);
    final mexican = ref.watch(mexicanSeriesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // Top 10 Series en Swiper
                  TvSeriesSlidershow(series: slideshowSeries),

                  // Series Actuales (Airing Today)
                  TvSeriesHorizontalListview(
                    series: airingToday,
                    title: 'Series Actuales',
                    subTitle: 'Al Aire Hoy',
                    loadNextPage: () => ref
                        .read(airingTodaySeriesProvider.notifier)
                        .loadNextPage(),
                  ),

                  // Series Por Estrenarse (incluir temporada)
                  TvSeriesHorizontalListview(
                    series: onTheAir,
                    title: 'Por Estrenarse',
                    subTitle: currentMonthName,
                    showSeasonInfo: true,
                    loadNextPage: () =>
                        ref.read(onTheAirSeriesProvider.notifier).loadNextPage(),
                  ),

                  // Series Populares
                  TvSeriesHorizontalListview(
                    series: popular,
                    title: 'Series Populares',
                    subTitle: null,
                    loadNextPage: () =>
                        ref.read(popularSeriesProvider.notifier).loadNextPage(),
                  ),

                  // Series Mejor Valoradas
                  TvSeriesHorizontalListview(
                    series: topRated,
                    title: 'Mejor Valoradas',
                    subTitle: null,
                    loadNextPage: () =>
                        ref.read(topRatedSeriesProvider.notifier).loadNextPage(),
                  ),

                  // Series Mexicanas
                  TvSeriesHorizontalListview(
                    series: mexican,
                    title: 'Series Mexicanas',
                    subTitle: null,
                    loadNextPage: () =>
                        ref.read(mexicanSeriesProvider.notifier).loadNextPage(),
                  ),

                  const SizedBox(height: 10),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
