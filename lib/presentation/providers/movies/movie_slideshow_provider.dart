import 'package:cinemapedia_220512/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220512/domain/entities/movie.dart';

// Provider que filtra y retorna solo las primeras 6 películas para el slideshow
// Se recalcula automáticamente cuando nowPlayingMoviesProvider cambia
final movieSlideshowProvider = Provider<List<Movie>>((ref) {
  // ref.watch escucha cambios en nowPlayingMoviesProvider
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  // Validación para evitar errores si aún no hay películas cargadas
  if (nowPlayingMovies.isEmpty) return [];

  // sublist(0, 6) extrae solo las primeras 6 películas para mostrar en el carrusel
  return nowPlayingMovies.sublist(0, 6);
});
