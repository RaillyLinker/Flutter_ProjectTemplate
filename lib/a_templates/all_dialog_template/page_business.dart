// (external)
import 'package:flutter/cupertino.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_view.dart' as page_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class PageBusiness
    extends State<page_view.PageView>
    with WidgetsBindingObserver {
  PageBusiness({required this.pageInputVo});

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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

    // !!!state dispose 로직 작성!!!
  }

  // [public 변수]
  // (연결된 위젯 변수) - 생성자 실행 이후 not null
  page_view.PageView? view;

  // (페이지 입력 데이터)
  final page_view.PageInputVo pageInputVo;

  // (페이지 pop 가능 여부 변수)
  bool pageCanPop = true;

  // [private 변수]

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
}
