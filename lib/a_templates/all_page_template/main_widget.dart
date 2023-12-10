// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (all)
import '../../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;

// [위젯 뷰]

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!! - 파일명과 동일하게 작성하세요.
const pageName = "all_page_template";

// !!!페이지 호출/반납 애니메이션!!! - 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

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

//------------------------------------------------------------------------------
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

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
    final InputVo? inputVo = onCheckPageInputVo();
    if (inputVo == null) {
      _inputError = true;
    } else {
      this.inputVo = inputVo;
    }

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

  InputVo? onCheckPageInputVo() {
    // !!!pageInputVo 체크!!! - 필수 정보 누락시 null 반환
    // ex :
    // if (!widget.goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const InputVo();
  }

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [public 변수]
  // (위젯 입력값)
  late InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  // [private 변수]
  // (입력값 미충족 여부)
  bool _inputError = false;

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required BuildContext context}) {
    if (_inputError == true) {
      // 입력값이 미충족 되었을 때의 화면
      return gw_slw_page_outer_frame.SlwPageOuterFrame(
        business: pageOutFrameBusiness,
        pageTitle: "페이지 템플릿",
        child: const Center(
          child: Text(
            "잘못된 접근입니다.",
            style: TextStyle(color: Colors.red, fontFamily: "MaruBuri"),
          ),
        ),
      );
    }

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: pageOutFrameBusiness,
      pageTitle: "페이지 템플릿",
      child: const Center(
        child: Text(
          "템플릿 페이지",
          style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
        ),
      ),
    );
  }
}
