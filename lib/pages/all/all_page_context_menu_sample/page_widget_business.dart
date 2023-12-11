// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

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
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  var contextMenuRegionGk =
      GlobalKey<gw_sfw_wrapper.SfwContextMenuRegionState>();

  var contextMenuRegionGk2 =
      GlobalKey<gw_sfw_wrapper.SfwContextMenuRegionState>();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (context 메뉴의 토스트 테스트 항목을 클릭)
  void toastTestMenuBtn() {
    showToast(
      "토스트 테스트 메뉴가 선택되었습니다.",
      context: context,
      animation: StyledToastAnimation.scale,
    );
  }

  // (context 메뉴의 다이얼로그 테스트 항목을 클릭)
  void dialogTestMenuBtn() {
    final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
        GlobalKey<all_dialog_info.MainWidgetState>();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_info.MainWidget(
              key: allDialogInfoStateGk,
              inputVo: all_dialog_info.InputVo(
                dialogTitle: "컨텍스트 메뉴 테스트",
                dialogContent: "다이얼로그 테스트 메뉴가\n선택되었습니다.",
                checkBtnTitle: "확인",
                onDialogCreated: () {},
              ),
            ));
  }

  // (context 메뉴의 뒤로가기 항목을 클릭)
  void goBackBtn() {
    context.pop();
  }

// [private 함수]
}
