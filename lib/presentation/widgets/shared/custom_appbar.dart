import 'package:flutter/material.dart';

// Widget personalizado para la barra superior de la app
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtengo los colores del tema actual de la app
    final colors = Theme.of(context).colorScheme;
    // Obtengo el estilo de texto predefinido para títulos medianos
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    // SafeArea evita que el contenido se sobreponga con el notch o barra de estado
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia-220512', style: titleStyle),
              // Spacer empuja los elementos restantes hacia la derecha
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
        ),
      ),
    );
  }
}
