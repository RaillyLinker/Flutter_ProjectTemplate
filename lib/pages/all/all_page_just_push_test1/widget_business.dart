// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'widget_view.dart' as widget_view;
import 'inner_widgets/iw_sample_number_text/sf_widget_state.dart'
    as iw_sample_number_text_state;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../pages/all/all_page_just_push_test1/widget_view.dart'
    as all_page_just_push_test1;
import '../../../pages/all/all_page_just_push_test2/page_entrance.dart'
    as all_page_just_push_test2;
import '../../../global_widgets/gw_stateful_test/sf_widget_state.dart'
    as gw_stateful_test_state;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class WidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
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

  Future<void> onCheckPageInputVoAsync(
      {required GoRouterState goRouterState}) async {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }
    if (kDebugMode) {
      print("+++ onCheckPageInputVoAsync 호출됨");
    }

    // !!!PageInputVo 입력!!!
    inputVo = const widget_view.InputVo();
  }

  // [public 변수]
  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // pageOutFrameBusiness
  gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameGk =
      gw_page_outer_frame_business.SlWidgetBusiness();

  // sampleNumberTextBusiness
  final GlobalKey<iw_sample_number_text_state.SfWidgetState>
      sampleNumberTextGk = GlobalKey();

  // statefulTestBusiness
  var statefulTestGk = GlobalKey<gw_stateful_test_state.SfWidgetState>();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (just_push_test 로 이동)
  void goToJustPushTest1Page() {
    context.pushNamed(all_page_just_push_test1.pageName);
  }

  // (just_push_test 로 이동)
  void goToJustPushTest2Page() {
    context.pushNamed(all_page_just_push_test2.pageName);
  }

  // (화면 카운트 +1)
  void countPlus1() {
    sampleNumberTextGk.currentState?.sampleInt += 1;
    sampleNumberTextGk.currentState?.refreshUi();
  }

// [private 함수]
}
