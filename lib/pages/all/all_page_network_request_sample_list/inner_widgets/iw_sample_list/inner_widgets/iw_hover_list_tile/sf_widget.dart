// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo({required this.onItemClicked, required this.listTileChild});

  final void Function() onItemClicked;
  final Widget listTileChild;
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

    return MouseRegion(
      // 커서 변경 및 호버링 상태 변경
      cursor: SystemMouseCursors.click,
      onEnter: (details) {
        currentState.isHovering = true;
        currentState.refreshUi();
      },
      onExit: (details) {
        currentState.isHovering = false;
        currentState.refreshUi();
      },
      child: GestureDetector(
        // 클릭시 제스쳐 콜백
        onTap: () {
          inputVo.onItemClicked();
        },
        child: Container(
          color: currentState.isHovering
              ? Colors.blue.withOpacity(0.2)
              : Colors.white,
          child: inputVo.listTileChild,
        ),
      ),
    );
  }
}
