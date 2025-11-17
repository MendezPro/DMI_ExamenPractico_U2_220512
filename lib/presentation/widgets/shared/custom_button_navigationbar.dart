import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget personalizado para la barra de navegación inferior con funcionalidad.
///
/// **Navegación:**
/// - Inicio: Pantalla de películas
/// - Series: Pantalla de series de TV
/// - Favoritos: Próximamente
class CustomButtonNavigationbar extends StatelessWidget {
  final int currentIndex;

  const CustomButtonNavigationbar({
    super.key,
    this.currentIndex = 0,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/series');
        break;
      case 2:
        // Funcionalidad de favoritos - próximamente
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_outlined),
          activeIcon: Icon(Icons.movie),
          label: 'Películas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tv_outlined),
          activeIcon: Icon(Icons.tv),
          label: 'Series',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
