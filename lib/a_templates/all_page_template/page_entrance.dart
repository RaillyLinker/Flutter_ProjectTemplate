// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [페이지 진입 파일]

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_template";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (페이지 호출시 필요한 입력값 데이터 형태)
// !!!페이지 입력 데이터 정의!!!
class PageInputVo {}

// (이전 페이지로 전달할 결과 데이터 형태)
// !!!페이지 반환 데이터 정의!!!
class PageOutputVo {}

//------------------------------------------------------------------------------
class PageEntrance extends StatefulWidget {
  PageEntrance(
      {super.key, required this.state, required GoRouterState goRouterState}) {
    pageInputVo = state.getInputVo(goRouterState);
  }

  // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
  // (위젯 비즈니스)
  final PageEntranceState state;

  // (페이지 입력 데이터)
  late final PageInputVo pageInputVo;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  PageEntranceState createState() => state;
}

class PageEntranceState extends State<PageEntrance>
    with WidgetsBindingObserver {
  PageEntranceState();

  // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
  // (페이지 pop 가능 여부 변수)
  bool pageCanPop = true;

  // (pageOutFrameBusiness)
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
      gw_page_out_frames.PageOutFrameBusiness();

  // [외부 공개 함수]

  // [내부 함수]
  // (goRouterState 에서 PageInputVo 를 추출)
  PageInputVo getInputVo(GoRouterState goRouterState) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    return PageInputVo();
  }

  // (페이지 위젯 initState)
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // (페이지 위젯 dispose)
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageCanPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {},
        onFocusLost: () async {},
        onVisibilityGained: () async {},
        onVisibilityLost: () async {},
        onForegroundGained: () async {},
        onForegroundLost: () async {},

        // (페이지 UI 위젯)
        child: gw_page_out_frames.PageOutFrame(
          pageTitle: "페이지 템플릿",
          business: pageOutFrameBusiness,
          floatingActionButton: null,
          child: const Center(
            child: Text(
              "페이지 템플릿입니다.",
              style: TextStyle(fontFamily: "MaruBuri"),
            ),
          ),
        ),
      ),
    );
  }
}
