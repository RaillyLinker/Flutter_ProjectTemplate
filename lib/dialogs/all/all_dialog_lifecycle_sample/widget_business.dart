// (external)
import 'package:flutter/cupertino.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;
import 'inner_widgets/iw_stateful_sample_number/widget_business.dart'
    as iw_stateful_sample_number_business;
import '../../../pages/all/all_page_dialog_sample_list/page_entrance.dart'
    as all_page_dialog_sample_list;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness extends State<widget_view.WidgetView>
    with WidgetsBindingObserver {
  WidgetBusiness();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
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
  widget_view.WidgetView? view;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  iw_stateful_sample_number_business.WidgetBusiness
      statefulSampleNumberBusiness =
      iw_stateful_sample_number_business.WidgetBusiness();

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

  void pushToAnotherPage() {
    context.pushNamed(all_page_dialog_sample_list.pageName);
  }

// [private 함수]
}
