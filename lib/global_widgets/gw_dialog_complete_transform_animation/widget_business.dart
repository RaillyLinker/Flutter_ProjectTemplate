// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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

  // (다이얼로그 작업 완료 여부)
  bool isComplete = false;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    statefulGk.currentState?.refreshUi();
  }

  // (다이얼로그 완료)
  Future<void> dialogComplete() async {
    isComplete = true;
    refreshUi();

    // 애니메이션의 지속 시간만큼 지연
    await Future.delayed(widget.inputVo.completeCloseDuration);

    // 다이얼로그 닫기
    if (!context.mounted) return;
    context.pop();
  }

// [private 함수]
}
