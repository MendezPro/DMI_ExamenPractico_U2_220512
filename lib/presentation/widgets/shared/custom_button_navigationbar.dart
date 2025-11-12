import 'package:flutter/material.dart';

// Widget personalizado para la barra de navegación inferior
class CustomButtonNavigationbar extends StatelessWidget {
  const CustomButtonNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    // BottomNavigationBar crea la barra de navegación con múltiples pestañas
    return BottomNavigationBar(
      // Lista de items que aparecerán como opciones en la barra inferior
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Incio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outlined),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outlined),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
