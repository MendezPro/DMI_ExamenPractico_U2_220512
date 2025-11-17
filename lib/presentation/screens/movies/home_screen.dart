import 'package:cinemapedia_220512/presentation/providers/providers.dart';
import 'package:cinemapedia_220512/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
 
/// Pantalla principal de la aplicación que muestra las películas en cartelera.

/// Pantalla principal de la aplicación que muestra las películas en cartelera.
class HomeScreen extends StatelessWidget {
  /// Identificador único para navegación con GoRouter
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtonNavigationbar(currentIndex: 0),
    );
  }
}

/// Vista interna que maneja el estado y la lógica de la pantalla principal.
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

/// Estado que gestiona el ciclo de vida y la construcción de la vista.
class _HomeViewState extends ConsumerState<_HomeView> {
  bool _isLoading = true;
  bool _minTimeElapsed = false;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null);
    
    // Verificar si ya se mostró el loading inicial
    final hasLoadedBefore = ref.read(appInitialLoadingProvider);
    
    // Cargar datos
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(mexicanMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();

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


    // Verificar si los datos están cargados cada 500ms
    _checkDataLoading();
  }

  void _checkDataLoading() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      final nowPlaying = ref.read(nowPlayingMoviesProvider);
      final popular = ref.read(popularMoviesProvider);
      final upcoming = ref.read(upcomingMoviesProvider);
      final mexican = ref.read(mexicanMoviesProvider);
      final topRated = ref.read(topRatedMoviesProvider);

      if (nowPlaying.isNotEmpty && 
          popular.isNotEmpty && 
          upcoming.isNotEmpty && 
          mexican.isNotEmpty && 
          topRated.isNotEmpty) {
        setState(() {
          _dataLoaded = true;
          _checkLoadingComplete();
        });
      } else {
        // Seguir verificando
        _checkDataLoading();
      }
    });
  }

  void _checkLoadingComplete() {
    // Solo ocultar loading cuando AMBOS estén listos
    if (_minTimeElapsed && _dataLoaded && _isLoading) {
      setState(() {
        _isLoading = false;
      });
      // Marcar que ya se completó el loading inicial
      ref.read(appInitialLoadingProvider.notifier).markAsLoaded();
    }
  }

  /// Función para obtener la fecha actual formateada
  String get currentFormattedDate {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d \'de\' MMMM', 'es_ES');
    return formatter.format(now);
  }

  /// Función para obtener solo el nombre del mes actual
  String get currentMonthName {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM', 'es_ES');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    // Usar nuestra variable local en lugar del provider
    if (_isLoading) return const FullscreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(movieSlideshowProvider);
    final popular = ref.watch(popularMoviesProvider);
    final topRated = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final mexicanMovies = ref.watch(mexicanMoviesProvider);

    // Filtrar películas upcoming solo del mes actual
    final now = DateTime.now();
    final upcomingThisMonth = upcomingMovies.where((movie) {
      return movie.releaseDate.year == now.year &&
             movie.releaseDate.month == now.month;
    }).toList();

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
                  MovieSlidershow(movies: slideShowMovies),
                  
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: currentFormattedDate,
                    loadNextPage: () =>
                        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListview(
                    movies: upcomingThisMonth,
                    title: 'Proximamente',
                    subTitle: currentMonthName,
                    loadNextPage: () =>
                        ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                    showReleaseDate: true,
                  ),

                  MovieHorizontalListview(
                    movies: popular,
                    title: 'Populares',
                    subTitle: null,
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListview(
                    movies: topRated,
                    title: 'Mejor valoradas',
                    subTitle: currentFormattedDate,
                    loadNextPage: () =>
                        ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListview(
                    movies: mexicanMovies,
                    title: 'Cine Mexicano',
                    subTitle: currentFormattedDate,
                    loadNextPage: () =>
                        ref.read(mexicanMoviesProvider.notifier).loadNextPage(),
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