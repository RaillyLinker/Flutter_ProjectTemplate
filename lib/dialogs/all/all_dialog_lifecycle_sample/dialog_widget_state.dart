// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'dialog_widget.dart' as dialog_widget;
import 'inner_widgets/iw_stateful_sample_number/sf_widget_state.dart'
    as iw_stateful_sample_number_state;

// (all)
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_dialog_sample_list/page_widget.dart'
    as all_page_dialog_sample_list;
import '../../../global_widgets/gw_stateful_test/sf_widget_state.dart'
    as gw_stateful_test_state;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class DialogWidgetState extends State<dialog_widget.DialogWidget>
    with WidgetsBindingObserver {
  DialogWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (needInitState) {
            needInitState = false;
            widget.onDialogCreated();
          }

          // !!!생명주기 처리!!!
          if (kDebugMode) {
            print("$randString : onFocusGained");
          }
        },
        onFocusLost: () async {
          // !!!생명주기 처리!!!
          if (kDebugMode) {
            print("$randString : onFocusLost");
          }
        },
        onVisibilityGained: () async {
          // !!!생명주기 처리!!!
          if (kDebugMode) {
            print("$randString : onVisibilityGained");
          }
        },
        onVisibilityLost: () async {
          // !!!생명주기 처리!!!
          if (kDebugMode) {
            print("$randString : onVisibilityLost");
          }
        },
        onForegroundGained: () async {
          // !!!생명주기 처리!!!
          if (kDebugMode) {
            print("$randString : onForegroundGained");
          }
        },
        onForegroundLost: () async {
          // !!!생명주기 처리!!!
          if (kDebugMode) {
            print("$randString : onForegroundLost");
          }
        },
        child: widget.widgetUiBuild(context: context, currentState: this),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.onDialogCreated();
    // !!!initState 작성!!!
    if (kDebugMode) {
      print("$randString : initState");
    }
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    if (kDebugMode) {
      print("$randString : dispose");
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (최초 실행 플래그)
  bool needInitState = true;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (로그 남기기 용 랜덤 문자열)
  final String randString = gf_my_functions.generateRandomString(10);

  // (statefulSampleNumberBusiness)
  final GlobalKey<iw_stateful_sample_number_state.SfWidgetState>
      statefulSampleNumberGk = GlobalKey();

  // (statefulTestBusiness)
  final GlobalKey<gw_stateful_test_state.SfWidgetState> statefulTestGk =
      GlobalKey();

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

  // (다른 페이지로 이동)
  void pushToAnotherPage() {
    context.pushNamed(all_page_dialog_sample_list.pageName);
  }
}
