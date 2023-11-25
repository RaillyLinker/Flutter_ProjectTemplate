// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  void onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
  }

  void onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  void onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  void onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  void onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  void onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  // [public 변수]
  // (위젯 state GlobalKey)
  final GlobalKey<widget_view.StatefulBusiness> statefulGk = GlobalKey();

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (위젯 Context)
  late BuildContext context;

  // (위젯 객체)
  late widget_view.StatefulView widget;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    statefulGk.currentState?.refreshUi();
  }

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

// [private 함수]
}
