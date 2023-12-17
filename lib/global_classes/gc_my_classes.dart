// (external)
import 'package:flutter/material.dart';

// [전역 클래스 선언 파일]
// 프로그램 전역에서 사용할 Class 를 선언하는 파일입니다.

// -----------------------------------------------------------------------------
// (AnimatedSwitcher 설정)
class AnimatedSwitcherConfig {
  AnimatedSwitcherConfig(
      {required this.duration,
      required this.reverseDuration,
      this.switchInCurve = Curves.linear,
      this.switchOutCurve = Curves.linear,
      this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
      this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder});

  Duration duration;
  Duration? reverseDuration;
  Curve switchInCurve;
  Curve switchOutCurve;
  AnimatedSwitcherTransitionBuilder transitionBuilder;
  AnimatedSwitcherLayoutBuilder layoutBuilder;

  AnimatedSwitcherConfig clone() {
    return AnimatedSwitcherConfig(
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        transitionBuilder: transitionBuilder,
        layoutBuilder: layoutBuilder);
  }
}
