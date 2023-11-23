// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class StatelessWidgetTemplateView extends StatelessWidget {
  StatelessWidgetTemplateView(
      {super.key,
      required widget_business.StatelessWidgetTemplateBusiness business})
      : _business = business {
    _business.view = this;
  }

  // [오버라이드]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return viewWidgetBuild(context: context);
  }

  // [public 변수]

  // [private 변수]
  // (위젯 비즈니스)
  final widget_business.StatelessWidgetTemplateBusiness _business;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return const Text("todo");
  }
}
