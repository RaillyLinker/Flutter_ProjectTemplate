// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo();
}

class WidgetView extends StatefulWidget {
  const WidgetView({required super.key, required this.inputVo});

  // [콜백 함수]
  @override
  widget_business.WidgetBusiness createState() =>
      widget_business.WidgetBusiness();

  // [public 변수]
  // (위젯 입력값)
  final InputVo inputVo;
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required InputVo inputVo,
      required widget_business.WidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!
    return const Text("todo");
  }
}
