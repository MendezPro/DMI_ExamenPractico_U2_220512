import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

/// Pantalla de Splash Screen con animación y audio
///
/// **Características:**
/// - Muestra logo CineVerse
/// - Reproduce audio de introducción
/// - Animación de entrada (FadeIn + ZoomIn)
/// - Transición automática a HomeScreen después de que termine el audio
class SplashScreen extends StatefulWidget {
  static const name = 'splash-screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _audioLoaded = false;

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  /// Inicializa el splash: reproduce audio y programa navegación
  Future<void> _initSplash() async {
    try {
      // Reproduce audio de splash
      await _audioPlayer.play(AssetSource('audio/introaudio.mp3'));
      setState(() {
        _audioLoaded = true;
      });
      
      // Escucha cuando termine el audio para navegar
      _audioPlayer.onPlayerComplete.listen((event) {
        if (mounted) {
          context.go('/home');
        }
      });
    } catch (e) {
      debugPrint('Error al reproducir audio: $e');
      // Si hay error con el audio, navega después de 4 segundos
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          context.go('/home');
        }
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Negro profundo
      body: Center(
        child: FadeIn(
          duration: const Duration(milliseconds: 1500),
          child: ZoomIn(
            duration: const Duration(milliseconds: 1500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo CineVerse
                Container(
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/LogoCineVerse.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Error al cargar logo: $error');
                        // Si no carga la imagen, muestra icono de respaldo
                        return Container(
                          color: Colors.black,
                          child: const Center(
                            child: Icon(
                              Icons.movie_creation_outlined,
                              size: 120,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Texto CineVerse
                const Text(
                  'CineVerse',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                
                const Text(
                  'el poder del cine',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Indicador de carga
                if (_audioLoaded)
                  Column(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: Colors.red.shade700,
                          strokeWidth: 4,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Cargando experiencia...',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
