import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

class ClaseGame extends FlameGame with HasKeyboardHandlerComponents {
  ClaseGame();

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 255);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'mapa_prueba.png',
      'mapa_bloques.png'
    ]);
  }
}