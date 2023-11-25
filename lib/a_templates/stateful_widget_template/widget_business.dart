// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  // [public 변수]
  // (위젯 state GlobalKey)
  final GlobalKey<widget_view.StatefulBusiness> statefulGk = GlobalKey();

  // (위젯 Context)
  late BuildContext context;

  // (위젯 객체)
  late widget_view.StatefulView widget;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    statefulGk.currentState?.refreshUi();
  }

// [private 함수]
}
