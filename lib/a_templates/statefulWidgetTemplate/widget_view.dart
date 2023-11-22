// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class StatelessWidgetTemplateView extends StatelessWidget {
  const StatelessWidgetTemplateView(
      {super.key,
      required widget_business.StatelessWidgetTemplateBusiness business,
      required this.sampleText})
      : _business = business;

  // [오버라이드]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return viewWidgetBuild(context: context);
  }

  // [public 변수]
  // !!!public 변수를 선언 하세요!!!
  // (샘플 변수)
  final String sampleText;

  // [private 변수]
  // !!!private 변수를 선언 하세요!!!
  // (위젯 비즈니스)
  final widget_business.StatelessWidgetTemplateBusiness _business;

  // [public 함수]
  // !!!public 함수를 작성 하세요!!!
  // (뷰 위젯을 반환 하는 함수)
  Widget viewWidgetBuild({required BuildContext context}) {
    // !!!뷰 하위 위젯을 작성 하세요!!!

    _business.sampleFunc(text: "test");

    return Text(sampleText);
  }

// [private 함수]
// !!!private 함수를 작성 하세요!!!
}
