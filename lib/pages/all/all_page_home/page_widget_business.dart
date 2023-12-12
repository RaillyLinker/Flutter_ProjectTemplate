// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_do_delete.dart'
    as todo_do_delete;
import 'package:flutter_project_template/pages/all/all_page_page_and_router_sample_list/page_widget.dart'
    as all_page_page_and_router_sample_list;
import 'package:flutter_project_template/pages/all/all_page_dialog_sample_list/page_widget.dart'
    as all_page_dialog_sample_list;
import 'package:flutter_project_template/pages/all/all_page_dialog_animation_sample_list/page_widget.dart'
    as all_page_dialog_animation_sample_list;
import 'package:flutter_project_template/pages/all/all_page_network_request_sample_list/page_widget.dart'
    as all_page_network_request_sample_list;
import 'package:flutter_project_template/pages/all/all_page_auth_sample/page_widget.dart'
    as all_page_auth_sample;
import 'package:flutter_project_template/pages/all/all_page_etc_sample_list/page_widget.dart'
    as all_page_etc_sample_list;

// (mobile)
import 'package:flutter_project_template/pages/mobile/mobile_page_permission_sample_list/page_entrance.dart'
    as mobile_page_permission_sample_list;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
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

  page_widget.InputVo? onCheckPageInputVo(
      {required BuildContext context, required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!! - 필수 정보 누락시 null 반환
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const page_widget.InputVo();
  }

  // [public 변수]
  // (페이지 뷰모델 객체)
  late PageWidgetViewModel viewModel;

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void onPageRouterSampleItemClicked() {
    viewModel.context.pushNamed(all_page_page_and_router_sample_list.pageName);
  }

  void onDialogSampleItemClicked() {
    viewModel.context.pushNamed(all_page_dialog_sample_list.pageName);
  }

  void onDialogAnimationSampleItemClicked() {
    viewModel.context.pushNamed(all_page_dialog_animation_sample_list.pageName);
  }

  void onNetworkRequestSampleItemClicked() {
    viewModel.context.pushNamed(all_page_network_request_sample_list.pageName);
  }

  void onMobilePermissionSampleItemClicked() {
    viewModel.context.pushNamed(mobile_page_permission_sample_list.pageName);
  }

  void onAuthSampleItemClicked() {
    viewModel.context.pushNamed(all_page_auth_sample.pageName);
  }

  void onEtcSampleItemClicked() {
    viewModel.context.pushNamed(all_page_etc_sample_list.pageName);
  }

// !!!사용 함수 추가하기!!!
}

// (페이지에서 사용할 변수 저장 클래스)
class PageWidgetViewModel {
  PageWidgetViewModel(
      {required this.context, required page_widget.InputVo? inputVo}) {
    if (inputVo == null) {
      // !!!InputVo 가 충족 되지 않은 경우에 대한 처리!!!
      context.pop();
    } else {
      this.inputVo = inputVo;
    }
  }

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (페이지 컨텍스트 객체)
  BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();
  final GlobalKey<todo_do_delete.SfwListViewBuilderState>
      sfwListViewBuilderStateGk = GlobalKey();
}
