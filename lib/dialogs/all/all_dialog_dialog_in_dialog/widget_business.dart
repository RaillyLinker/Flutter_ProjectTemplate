// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// (all)
import '../../../dialogs/all/all_dialog_loading_spinner/widget_view.dart'
    as all_dialog_loading_spinner_view;
import '../../../dialogs/all/all_dialog_loading_spinner/widget_business.dart'
    as all_dialog_loading_spinner_business;
import '../../../dialogs/all/all_dialog_info/widget_view.dart'
    as all_dialog_info_view;
import '../../../dialogs/all/all_dialog_info/widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_dialog_in_dialog/widget_view.dart'
    as all_dialog_dialog_in_dialog_view;
import '../../../dialogs/all/all_dialog_dialog_in_dialog/widget_business.dart'
    as all_dialog_dialog_in_dialog_business;

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

  // [public 변수]
  // (초기화 여부)
  bool onPageCreated = false;

  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  // (Info 다이얼로그 호출)
  void showInfoDialog() {
    var allDialogInfoBusiness = all_dialog_info_business.WidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_info_view.WidgetView(
              business: allDialogInfoBusiness,
              inputVo: const all_dialog_info_view.InputVo(
                  dialogTitle: "확인 다이얼로그",
                  dialogContent: "확인 다이얼로그를 호출했습니다.",
                  checkBtnTitle: "확인"),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

  // (Loading 다이얼로그 호출)
  void showLoadingDialog() {
    var allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.WidgetBusiness();

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_loading_spinner_view.WidgetView(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner_view.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});
  }

  // (현재 다이얼로그 다시 호출)
  void showDialogInDialog() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    var allDialogDialogInDialogViewBusiness =
        all_dialog_dialog_in_dialog_business.WidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_dialog_in_dialog_view.WidgetView(
              business: allDialogDialogInDialogViewBusiness,
              inputVo: const all_dialog_dialog_in_dialog_view.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

// [private 함수]
}
