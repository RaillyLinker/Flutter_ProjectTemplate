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

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

class SfWidget extends StatefulWidget {
  const SfWidget(
      {required this.globalKey,
      required this.inputVo,
      required this.onDialogCreated})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  sf_widget_state.SfWidgetState createState() =>
      sf_widget_state.SfWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<sf_widget_state.SfWidgetState> globalKey;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  // [화면 작성]
  Widget widgetUiBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          height: 280,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: const Center(
            child: Text(
              "다이얼로그 템플릿",
              style: TextStyle(fontFamily: "MaruBuri"),
            ),
          ),
        ),
      ),
    );
  }
}
