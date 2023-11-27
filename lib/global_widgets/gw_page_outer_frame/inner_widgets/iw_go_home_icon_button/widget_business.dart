// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  // [콜백 함수]
  // (Stateful Widget initState)
  void initState(widget_view.StatefulState statefulState) {}

  // (Stateful Widget dispose)
  void dispose(widget_view.StatefulState statefulState) {}

  // [public 변수]
  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (위젯 호버링 여부)
  bool isHovering = false;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  late VoidCallback refreshUi;

// [private 함수]
}
