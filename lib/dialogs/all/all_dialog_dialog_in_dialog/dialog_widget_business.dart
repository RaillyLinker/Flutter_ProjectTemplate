// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'dialog_widget.dart' as dialog_widget;

// (all)
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_business.dart'
    as all_dialog_loading_spinner_business;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_business.dart'
    as all_dialog_info_business;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class DialogWidgetBusiness {
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

  // [public 변수]
  // (페이지 뷰모델 객체)
  late PageWidgetViewModel viewModel;

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    viewModel.context.pop();
  }

  // (Info 다이얼로그 호출)
  void showInfoDialog() {
    final all_dialog_info_business.DialogWidgetBusiness allDialogInfoBusiness =
        all_dialog_info_business.DialogWidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_info.DialogWidget(
              business: allDialogInfoBusiness,
              inputVo: const all_dialog_info.InputVo(
                  dialogTitle: "확인 다이얼로그",
                  dialogContent: "확인 다이얼로그를 호출했습니다.",
                  checkBtnTitle: "확인"),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

  // (Loading 다이얼로그 호출)
  void showLoadingDialog() {
    final all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});
  }

  // (현재 다이얼로그 다시 호출)
  void showDialogInDialog() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    final DialogWidgetBusiness allDialogDialogInDialogBusiness =
        DialogWidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => dialog_widget.DialogWidget(
              business: allDialogDialogInDialogBusiness,
              inputVo: const dialog_widget.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

// !!!사용 함수 추가하기!!!
}

// (페이지에서 사용할 변수 저장 클래스)
class PageWidgetViewModel {
  PageWidgetViewModel({required this.context, required this.inputVo});

  // (최초 실행 플래그)
  bool needInitState = true;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (페이지 컨텍스트 객체)
  BuildContext context;

  // (위젯 입력값)
  dialog_widget.InputVo inputVo;

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!
}