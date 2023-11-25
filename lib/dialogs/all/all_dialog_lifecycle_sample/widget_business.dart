// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;
import 'inner_widgets/iw_stateful_sample_number/widget_business.dart'
    as iw_stateful_sample_number_business;

// (all)
import '../../../pages/all/all_page_dialog_sample_list/page_entrance.dart'
    as all_page_dialog_sample_list;
import '../../../global_widgets/gw_stateful_test/widget_business.dart'
    as gw_stateful_test_business;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
    if (kDebugMode) {
      print("initState");
    }
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
    if (kDebugMode) {
      print("dispose");
    }
  }

  // (전체 위젯의 FocusDetector 콜백들)
  void onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
    if (kDebugMode) {
      print("onFocusGained");
    }
  }

  void onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
    if (kDebugMode) {
      print("onFocusLost");
    }
  }

  void onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
    if (kDebugMode) {
      print("onVisibilityGained");
    }
  }

  void onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
    if (kDebugMode) {
      print("onVisibilityLost");
    }
  }

  void onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
    if (kDebugMode) {
      print("onForegroundGained");
    }
  }

  void onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
    if (kDebugMode) {
      print("onForegroundLost");
    }
  }

  // [public 변수]
  // (위젯 state GlobalKey)
  final GlobalKey<widget_view.StatefulBusiness> statefulGk = GlobalKey();

  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  iw_stateful_sample_number_business.WidgetBusiness
      statefulSampleNumberBusiness =
      iw_stateful_sample_number_business.WidgetBusiness();

  gw_stateful_test_business.WidgetBusiness statefulTestBusiness =
      gw_stateful_test_business.WidgetBusiness();

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    statefulGk.currentState?.refreshUi();
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
