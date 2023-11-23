// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_entrance.dart' as page_entrance;
import 'page_view.dart' as page_view;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class PageBusiness extends State<page_view.PageView> {
  PageBusiness();

  // [오버라이드]
  @override
  Widget build(BuildContext context) {
    return widget.viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (연결된 위젯 변수) - 생성자 실행 이후 not null
  page_view.PageView? view;

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

  // (goRouterState 에서 PageInputVo 를 추출)
  page_entrance.PageInputVo getInputVo(GoRouterState goRouterState) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    return page_entrance.PageInputVo();
  }

  Future<void> initPageState() async {
    // !!!initPageState 작성!!!
  }

  Future<void> pageDispose() async {
    // !!!pageDispose 작성!!!
  }

  Future<void> onPageFocusGained() async {
    // !!!onPageFocusGained 작성!!!
  }

  Future<void> onPageFocusLost() async {
    // !!!onPageFocusLost 작성!!!
  }

  Future<void> onPageVisibilityGained() async {
    // !!!onPageVisibilityGained 작성!!!
  }

  Future<void> onPageVisibilityLost() async {
    // !!!onPageVisibilityLost 작성!!!
  }

  Future<void> onPageForegroundGained() async {
    // !!!onPageForegroundGained 작성!!!
  }

  Future<void> onPageForegroundLost() async {
    // !!!onPageForegroundLost 작성!!!
  }

// [private 함수]
}
