// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'dialog_widget_state.dart' as dialog_widget_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

class DialogWidget extends StatefulWidget {
  const DialogWidget(
      {required this.globalKey,
      required this.inputVo,
      required this.onDialogCreated})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  dialog_widget_state.DialogWidgetState createState() =>
      dialog_widget_state.DialogWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<dialog_widget_state.DialogWidgetState> globalKey;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required dialog_widget_state.DialogWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return SingleChildScrollView(
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(child: Container()),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    currentState.closeDialog();
                  },
                ),
              ],
            ),
            const Expanded(
              child: Text(
                "테스트 다이얼로그",
                style: TextStyle(fontFamily: "MaruBuri"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
