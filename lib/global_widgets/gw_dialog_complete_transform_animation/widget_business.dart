// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness extends State<widget_view.WidgetView> {
  WidgetBusiness();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (다이얼로그 작업 완료 여부)
  bool isComplete = false;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (다이얼로그 완료)
  Future<void> dialogComplete() async {
    isComplete = true;
    refreshUi();

    // 애니메이션의 지속 시간만큼 지연
    await Future.delayed(widget.completeCloseDuration);

    // 다이얼로그 닫기
    if (!context.mounted) return;
    context.pop();
  }

// [private 함수]
}
