// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'sf_widget.dart' as sf_widget;
import 'inner_widgets/iw_sample_number_text/sf_widget_state.dart'
    as iw_sample_number_text_state;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../pages/all/all_page_just_push_test2/page_entrance.dart'
    as all_page_just_push_test2;
import '../../../global_widgets/gw_stateful_test/sf_widget_state.dart'
    as gw_stateful_test_state;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class SfWidgetState extends State<sf_widget.SfWidget>
    with WidgetsBindingObserver {
  SfWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          // !!!생명주기 처리!!!
        },
        onFocusLost: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityGained: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityLost: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundGained: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundLost: () async {
          // !!!생명주기 처리!!!
        },
        child: widget.widgetUiBuild(context: context, currentState: this),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    onCheckPageInputVo();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  void onCheckPageInputVo() {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!widget.goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }
    if (kDebugMode) {
      print("+++ onCheckPageInputVoAsync 호출됨");
    }

    // !!!PageInputVo 입력!!!
    widget.inputVo = const sf_widget.InputVo();
  }

  // [public 변수]
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
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (just_push_test 로 이동)
  void goToJustPushTest1Page() {
    context.pushNamed(sf_widget.pageName);
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
}
