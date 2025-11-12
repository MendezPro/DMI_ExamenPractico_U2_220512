import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia_220512/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget que muestra un carrusel de imágenes de películas.
///
/// **Funcionalidades:**
/// - Carrusel automático con efecto de escala
/// - Imágenes con bordes redondeados y sombras
/// - Navegación manual mediante deslizamiento
/// - Muestra título, fecha de estreno y clasificación
class MovieSlidershow extends StatelessWidget {
  final List<Movie> movies;

  const MovieSlidershow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 250,
      // double.infinity hace que ocupe todo el ancho disponible
      width: double.infinity,
      child: Swiper(
        // viewportFraction 0.8 significa que cada slide ocupa el 80% del ancho
        viewportFraction: 0.8,
        // scale 0.9 reduce ligeramente los slides laterales para dar profundidad
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

/// Widget interno que representa cada slide individual del carrusel.
///
/// **Características:**
/// - Imagen con bordes redondeados
/// - Sombra para efecto de profundidad
/// - Overlay con título, fecha y clasificación
/// - Efectos de transparencia y sombreado
class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  /// Obtiene la clasificación de la película basada en criterios
  String _getMovieRating(Movie movie) {
    // Si es para adultos, es clasificación R
    if (movie.adult) return 'R';
    
    // Basado en el promedio de votos (rating)
    if (movie.voteAverage >= 7.5) return 'PG';
    if (movie.voteAverage >= 6.0) return 'PG-13';
    return 'P';
  }

  /// Color de la píldora según clasificación
  Color _getRatingColor(String rating) {
    switch (rating) {
      case 'R':
        return Colors.red.shade700;
      case 'PG-13':
        return Colors.orange.shade700;
      case 'PG':
        return Colors.blue.shade700;
      default:
        return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    // BoxDecoration permite agregar estilos visuales como sombras y bordes
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 19,
          // offset(0, 10) mueve la sombra 10 píxeles hacia abajo
          offset: Offset(0, 10),
        ),
      ],
    );

    final rating = _getMovieRating(movie);
    final dateFormat = DateFormat('dd MMM yyyy', 'es');

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen de fondo
              Positioned.fill(
                child: Image.network(
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    return child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error_outline));
                  },
                ),
              ),

              // Gradiente de sombreado para mejor legibilidad
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.5, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

              // Información de la película (título, fecha, clasificación)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Fila con clasificación
                      Row(
                        children: [
                          // Píldora de clasificación
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getRatingColor(rating),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              rating,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Fecha de estreno
                          Flexible(
                            child: Text(
                              dateFormat.format(movie.releaseDate),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Título de la película
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
