// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate(
      {super.key,
      required widget_business.StatefulWidgetTemplateBusiness business,
      required this.sampleText})
      : _business = business;

  // [오버라이드]
  @override
  // ignore: no_logic_in_create_state
  widget_business.StatefulWidgetTemplateBusiness createState() => _business;

  // [public 변수]
  // !!!하위 위젯 등 화면과 직접적 연관이 있는 public 변수를 선언 하세요!!!
  // (샘플 변수)
  final String sampleText;

  // [private 변수]
  // !!!하위 위젯 등 화면과 직접적 연관이 있는 private 변수를 선언 하세요!!!
  // (위젯 비즈니스)
  final widget_business.StatefulWidgetTemplateBusiness _business;

  // [public 함수]
  // !!!public 함수를 작성하세요!!!
  // (뷰 위젯을 반환 하는 함수)
  Widget viewWidgetBuild({required BuildContext context}) {
    // !!!뷰 하위 위젯을 작성 하세요!!!

    _business.sampleFunc(text: "test");

    return Text("$sampleText ${_business.sampleBool}");
  }

// [private 함수]
// !!!private 함수를 작성하세요!!!
}
