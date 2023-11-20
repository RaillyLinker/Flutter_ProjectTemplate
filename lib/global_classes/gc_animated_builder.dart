// (external)
import 'dart:math';
import 'package:flutter/cupertino.dart';

// [전역 클래스 선언 파일]
// 프로그램 전역에서 사용할 Class 를 선언하는 파일입니다.

// AnimatedSwitcher 에서 사용할 애니메이션

// -----------------------------------------------------------------------------
// (Flip Animation)
Widget wrapAnimatedBuilder(
    {required Widget child, required Animation<double> animation}) {
  final rotate = Tween(begin: pi, end: 0.0).animate(animation);

  return AnimatedBuilder(
      animation: rotate,
      child: child,
      builder: (_, widget) {
        final value = min(rotate.value, pi / 2);

        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.0025;

        tilt *= -1.0;

        return Transform(
            transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
            alignment: Alignment.center,
            child: widget);
      });
}
