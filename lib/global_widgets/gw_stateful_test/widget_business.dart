// (external)
import 'package:flutter/cupertino.dart';

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
  // (연결된 위젯 변수) - 생성자 실행 이후 not null
  widget_view.WidgetView? view;

  int sampleInt = 0;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (화면 카운트 +1)
  void countPlus1() {
    sampleInt += 1;
    refreshUi();
  }

// [private 함수]
}
