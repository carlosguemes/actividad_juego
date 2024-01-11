import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';
import '../games/ClaseGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<ClaseGame>,KeyboardHandler,CollisionCallbacks {

  int horizontalDirection = 0;
  int verticalDirection = 0;
  final Vector2 velocidad = Vector2.zero();
  double aceleracion = 500;
  bool derecha = true;

  double screenWidth = 0;
  bool saltoEnPared = false;
  bool enElAire = false;
  bool enLaPared = false;
  final double gravedad = 1200.0;
  final double alturaSalto = -500.0;

  final _collisionStartColor = Colors.black87;
  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  double posicionInicialY = 0.0;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center) {
    posicionInicialY = position.y;
  }

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..isSolid=true
      ..renderShape = true;
    add(hitbox);

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    if(other is Gota){
      this.removeFromParent();
    }
    else if(other is Estrella){
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    hitbox.paint.color = _collisionStartColor;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      hitbox.paint.color = _defaultColor;
    }
  }

  void saltar() {
    velocidad.y = alturaSalto;
    enElAire = true;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    /*if (position.x >= screenWidth - width / 2){
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && enLaPared){
        saltar();
        derecha = !derecha;
      }
    }

    else if (position.x <= width / 2){
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && enLaPared){
        saltar();
        derecha = !derecha;
      }
    }


    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && !enElAire) {
      saltar();
    }*/
    horizontalDirection = 0;
    verticalDirection = 0;
    // TODO: implement onKeyEvent

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
          keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        horizontalDirection = -1;
        verticalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
          keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        horizontalDirection = 1;
        verticalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        horizontalDirection = 1;
        verticalDirection = -1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
          keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        horizontalDirection = -1;
        verticalDirection = -1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        horizontalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        horizontalDirection = -1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        verticalDirection = 1;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        verticalDirection = -1;
      }

    return true;
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    position += velocidad * dt;

    screenWidth = gameRef.size.x;

    /*if (enElAire) {
      velocidad.y += gravedad * dt;
    }

    // Verificar si ha tocado el suelo
    if (position.y >= posicionInicialY) {
      position.y = posicionInicialY;
      enElAire = false;
      velocidad.y = 0;
    }

    //Movimiento hacia la izquierda si no está en el aire
    if (position.x > screenWidth - width / 2 && !enElAire) {
      derecha = !derecha;
      enLaPared = false;
    }

    //Se queda en la pared si está en el aire cuando está en la derecha
    if (position.x >= screenWidth - width / 2 && enElAire){
      position.x = screenWidth - width / 2;
      enLaPared = true;
    }

    //Movimiento hacia la derecha si no está en el aire
    if (position.x < width / 2 && !enElAire) {
      derecha = !derecha;
      enLaPared = false;
    }

    //Se queda en la pared si está en el aire cuando está en la izquierda
    if (position.x <= width / 2 && enElAire) {
      position.x = width / 2;
      enLaPared = true;
    }

    // Cambiar la dirección basada en la variable 'derecha'
    horizontalDirection = derecha ? 1 : -1;*/

    super.update(dt);
  }

}