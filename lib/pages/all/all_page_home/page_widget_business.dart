// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;
import 'inner_widgets/iw_sample_list/sf_widget_state.dart'
    as iw_sample_list_state;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../pages/all/all_page_page_and_router_sample_list/page_widget.dart'
    as all_page_page_and_router_sample_list;
import '../../../pages/all/all_page_dialog_sample_list/page_widget.dart'
    as all_page_dialog_sample_list;
import '../../../pages/all/all_page_dialog_animation_sample_list/page_widget.dart'
    as all_page_dialog_animation_sample_list;
import '../../../pages/all/all_page_network_request_sample_list/page_widget.dart'
    as all_page_network_request_sample_list;
import '../../../pages/all/all_page_auth_sample/page_entrance.dart'
    as all_page_auth_sample;
import '../../../pages/all/all_page_etc_sample_list/page_entrance.dart'
    as all_page_etc_sample_list;

// (mobile)
import '../../../pages/mobile/mobile_page_permission_sample_list/page_entrance.dart'
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

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  final GlobalKey<iw_sample_list_state.SfWidgetState> iwSampleListStateGk =
      GlobalKey();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void onPageRouterSampleListItemClicked() {
    context.pushNamed(all_page_page_and_router_sample_list.pageName);
  }

  void onDialogSampleListItemClicked() {
    context.pushNamed(all_page_dialog_sample_list.pageName);
  }

  void onDialogAnimationSampleListItemClicked() {
    context.pushNamed(all_page_dialog_animation_sample_list.pageName);
  }

  void onNetworkRequestSampleListItemClicked() {
    context.pushNamed(all_page_network_request_sample_list.pageName);
  }

  void onMobilePermissionSampleListItemClicked() {
    context.pushNamed(mobile_page_permission_sample_list.pageName);
  }

  void onAuthSampleItemClicked() {
    context.pushNamed(all_page_auth_sample.pageName);
  }

  void onEtcSampleListItemClicked() {
    context.pushNamed(all_page_etc_sample_list.pageName);
  }

// [private 함수]
}
