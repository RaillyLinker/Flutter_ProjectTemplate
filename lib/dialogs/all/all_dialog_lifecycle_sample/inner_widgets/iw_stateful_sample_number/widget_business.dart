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
  final GlobalKey<widget_view.StatefulState> statefulGk = GlobalKey();

  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (샘플 정수)
  int sampleInt = 0;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    statefulGk.currentState?.refreshUi();
  }

  // (화면 카운트 +1)
  void countPlus1() {
    sampleInt += 1;
    refreshUi();
  }

// [private 함수]
}
