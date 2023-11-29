// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'sl_widget_business.dart' as sl_widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

class SlWidget extends StatelessWidget {
  const SlWidget({super.key, required this.inputVo, required this.business});

  // [public 변수]
  final InputVo inputVo;
  final sl_widget_business.SlWidgetBusiness business;

  // [private 변수]

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return widgetUiBuild(context: context);
  }

  // [public 함수]

  // [private 함수]

  // [화면 작성]
  Widget widgetUiBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return const Text("todo");
  }
}
