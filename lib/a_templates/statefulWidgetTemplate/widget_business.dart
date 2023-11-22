// (external)
import 'package:flutter/foundation.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class StatelessWidgetTemplateBusiness {
  StatelessWidgetTemplateBusiness({required this.sampleBool});

  // [public 변수]
  // !!!public 변수를 선언 하세요!!!
  // (연결된 위젯 변수)
  late widget_view.StatelessWidgetTemplateView widget;

  // (샘플 변수)
  bool sampleBool;

  // [private 변수]
  // !!!private 변수를 선언 하세요!!!

  // [public 함수]
  // !!!public 함수를 작성하세요!!!
  // (샘플 public 함수)
  void sampleFunc({required String text}) {
    _samplePrivateFunc(text: sampleBool ? text : "");
  }

  // [private 함수]
  // !!!private 함수를 작성하세요!!!
  // (샘플 private 함수)
  void _samplePrivateFunc({required String text}) {
    if (kDebugMode) {
      print("$text : ${widget.sampleText}");
    }
  }
}
