import 'package:flutter_dotenv/flutter_dotenv.dart';

// Clase para manejar las variables de entorno de la aplicación

// Esta clase centraliza el acceso a todas las configuraciones sensibles
// que se almacenan en el archivo .env, como claves de API.
class Environment {

  /// Esta clave se obtiene del archivo .env bajo la variable THE_MOVIEDB_KEY.
  /// Es necesaria para realizar peticiones autenticadas a la API de TMDb
  /// y obtener información sobre películas, actores, géneros, etc.
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
}