// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo();
// !!!위젯 입력값 선언!!!
}

class WidgetView extends StatelessWidget {
  const WidgetView({super.key, required this.business, required this.inputVo});

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    business.context = context;
    business.widget = this;
    return viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;

  // (위젯 입력값)
  final InputVo inputVo;

  // [뷰 위젯]
  Widget viewWidgetBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!
    return const Text("todo");
  }
}
