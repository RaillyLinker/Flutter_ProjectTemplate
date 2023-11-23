// (external)
import 'package:flutter/cupertino.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_view.dart' as widget_view;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class PageBusiness extends State<widget_view.PageView>
    with WidgetsBindingObserver {
  PageBusiness({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    pageInputVo = widget_view.PageInputVo();
  }

  // [오버라이드]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageCanPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          // !!!onFocusGained 로직 작성!!!
        },
        onFocusLost: () async {
          // !!!onFocusLost 로직 작성!!!
        },
        onVisibilityGained: () async {
          // !!!onFocusLost 로직 작성!!!
        },
        onVisibilityLost: () async {
          // !!!onVisibilityLost 로직 작성!!!
        },
        onForegroundGained: () async {
          // !!!onForegroundGained 로직 작성!!!
        },
        onForegroundLost: () async {
          // !!!onForegroundLost 로직 작성!!!
        },
        child: widget.viewWidgetBuild(context: context),
      ),
    );
  }

  // (페이지 위젯 initState)
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // !!!state init 로직 작성!!!
  }

  // (페이지 위젯 dispose)
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

    // !!!state dispose 로직 작성!!!
  }

  // [public 변수]
  // (연결된 위젯 변수) - 생성자 실행 이후 not null
  widget_view.PageView? view;

  // (페이지 입력 데이터)
  late final widget_view.PageInputVo pageInputVo;

  // (페이지 pop 가능 여부 변수)
  bool pageCanPop = true;

  // (pageOutFrameBusiness)
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
      gw_page_out_frames.PageOutFrameBusiness();

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

// [private 함수]
}
