import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_220512/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget que muestra una lista horizontal de series de TV.
///
/// **Características:**
/// - Lista horizontal con scroll infinito
/// - Carga automática de más series al llegar al final
/// - Muestra póster, nombre, rating y fecha
class TvSeriesHorizontalListview extends StatefulWidget {
  final List<TvSeries> series;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  final bool showSeasonInfo;

  const TvSeriesHorizontalListview({
    super.key,
    required this.series,
    this.title,
    this.subTitle,
    this.loadNextPage,
    this.showSeasonInfo = false,
  });

  @override
  State<TvSeriesHorizontalListview> createState() =>
      _TvSeriesHorizontalListviewState();
}

class _TvSeriesHorizontalListviewState
    extends State<TvSeriesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Header(
              title: widget.title,
              subtitle: widget.subTitle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.series.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(
                  series: widget.series[index],
                  showSeasonInfo: widget.showSeasonInfo,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

/// Widget para cada tarjeta de serie individual
class _Slide extends StatelessWidget {
  final TvSeries series;
  final bool showSeasonInfo;

  const _Slide({
    required this.series,
    this.showSeasonInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Póster
          SizedBox(
            width: 150,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                series.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Nombre de la serie
          Flexible(
            child: SizedBox(
              width: 150,
              child: Text(
                series.name,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          const SizedBox(height: 3),

          // Rating o información de temporada
          SizedBox(
            width: 150,
            height: 20,
            child: showSeasonInfo
                ? _buildSeasonInfo(textStyles)
                : _buildRatingRow(textStyles),
          ),
        ],
      ),
    );
  }

  /// Construye la fila con rating
  Widget _buildRatingRow(TextTheme textStyles) {
    return Row(
      children: [
        Icon(Icons.star_half_outlined, color: Colors.yellow.shade800, size: 16),
        const SizedBox(width: 3),
        Text(
          '${series.voteAverage.toStringAsFixed(1)}',
          style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),
        ),
        const Spacer(),
        Icon(Icons.tv, color: Colors.grey.shade600, size: 14),
      ],
    );
  }

  /// Construye la información de temporada
  Widget _buildSeasonInfo(TextTheme textStyles) {
    final dateFormat = DateFormat('MMM yyyy', 'es');
    return Row(
      children: [
        Icon(Icons.calendar_today, color: Colors.blue.shade700, size: 14),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            dateFormat.format(series.firstAirDate),
            style: textStyles.bodySmall?.copyWith(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Header con título y subtítulo
class _Header extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Header({
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              child: Text(subtitle!),
            )
        ],
      ),
    );
  }
}
