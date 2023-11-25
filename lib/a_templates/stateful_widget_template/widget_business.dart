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
    return widget_view.WidgetUi.viewWidgetBuild(
        context: context, inputVo: widget.inputVo, business: this);
  }

  // [public 변수]

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

// [private 함수]
}
