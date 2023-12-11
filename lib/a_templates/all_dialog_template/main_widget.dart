// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// [위젯 뷰]

//------------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo({required this.onDialogCreated});

  // (다이얼로그가 생성된 시점에 한번 실행 되는 콜백)
  final VoidCallback onDialogCreated;
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class MainWidget extends StatefulWidget {
  const MainWidget({required super.key, required this.inputVo});

  final InputVo inputVo;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: FocusDetector(
        onFocusGained: () async {
          onFocusGained();
        },
        onFocusLost: () async {
          onFocusLost();
        },
        onVisibilityGained: () async {
          onVisibilityGained();
        },
        onVisibilityLost: () async {
          onVisibilityLost();
        },
        onForegroundGained: () async {
          onForegroundGained();
        },
        onForegroundLost: () async {
          onForegroundLost();
        },
        child: getScreenWidget(context: context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    inputVo = widget.inputVo;
    // !!!initState 로직 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 로직 작성!!!
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    if (_needInitState) {
      _needInitState = false;
      inputVo.onDialogCreated();
    }
    // !!!onFocusGained 로직 작성!!!
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [public 변수]
  // (위젯 입력값)
  late InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // [private 변수]
  // (최초 실행 플래그)
  bool _needInitState = true;

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required BuildContext context}) {
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
            child: Text("템플릿 다이얼로그"),
          ),
        ),
      ),
    );
  }
}
