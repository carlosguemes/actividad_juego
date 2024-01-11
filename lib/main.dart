import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'games/ClaseGame.dart';

void main() {
  runApp(
    const GameWidget<ClaseGame>.controlled(
      gameFactory: ClaseGame.new,
    ),
  );
}

