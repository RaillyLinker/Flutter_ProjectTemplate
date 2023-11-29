// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;
import 'inner_widgets/iw_stateful_sample_number/widget_business.dart'
    as iw_stateful_sample_number_business;

// (all)
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_dialog_sample_list/page_entrance.dart'
    as all_page_dialog_sample_list;
import '../../../global_widgets/gw_stateful_test/sf_widget_state.dart'
    as gw_stateful_test_state;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class WidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 처음 실행 콜백)
  Future<void> onCreated() async {
    // !!!onCreated 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onCreated");
    }
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
    if (kDebugMode) {
      print("$randString : dispose");
    }
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onFocusGained");
    }
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onFocusLost");
    }
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onVisibilityGained");
    }
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onVisibilityLost");
    }
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onForegroundGained");
    }
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
    if (kDebugMode) {
      print("$randString : onForegroundLost");
    }
  }

  // [public 변수]
  // (초기화 여부)
  bool onPageCreated = false;

  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (로그 남기기 용 랜덤 문자열)
  String randString = gf_my_functions.generateRandomString(10);

  // (statefulSampleNumberBusiness)
  iw_stateful_sample_number_business.WidgetBusiness
      statefulSampleNumberBusiness =
      iw_stateful_sample_number_business.WidgetBusiness();

  // (statefulTestBusiness)
  var statefulTestGk = GlobalKey<gw_stateful_test_state.SfWidgetState>();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  void pushToAnotherPage() {
    context.pushNamed(all_page_dialog_sample_list.pageName);
  }

// [private 함수]
}
