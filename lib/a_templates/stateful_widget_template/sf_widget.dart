// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
// !!!위젯 입력값 선언!!!
  const InputVo();
}

class SfWidget extends StatefulWidget {
  const SfWidget({required this.globalKey, required this.inputVo})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  sf_widget_state.SfWidgetState createState() =>
      sf_widget_state.SfWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<sf_widget_state.SfWidgetState> globalKey;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required sf_widget_state.SfWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return const Text("todo");
  }
}
