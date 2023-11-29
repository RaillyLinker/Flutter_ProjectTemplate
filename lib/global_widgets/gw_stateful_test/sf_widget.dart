// (external)
import 'package:flutter/material.dart';

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
  Widget widgetUiBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          globalKey.currentState?.countPlus1();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("${globalKey.currentState?.sampleInt}",
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: "MaruBuri")),
        ),
      ),
    );
  }
}
