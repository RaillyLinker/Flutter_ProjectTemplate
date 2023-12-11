// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/todo_do_delete.dart'
    as gw_do_delete;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/a_templates/all_dialog_template/main_widget.dart'
    as all_dialog_template;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/dialog_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/dialog_widget_business.dart'
    as all_dialog_yes_or_no_business;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/dialog_widget_business.dart'
    as all_dialog_loading_spinner_business;
import 'package:flutter_project_template/dialogs/all/all_dialog_modal_bottom_sheet_sample/dialog_widget.dart'
    as all_dialog_modal_bottom_sheet_sample;
import 'package:flutter_project_template/dialogs/all/all_dialog_modal_bottom_sheet_sample/dialog_widget_business.dart'
    as all_dialog_modal_bottom_sheet_sample_business;
import 'package:flutter_project_template/dialogs/all/all_dialog_dialog_in_dialog/dialog_widget.dart'
    as all_dialog_dialog_in_dialog;
import 'package:flutter_project_template/dialogs/all/all_dialog_dialog_in_dialog/dialog_widget_business.dart'
    as all_dialog_dialog_in_dialog_business;
import 'package:flutter_project_template/dialogs/all/all_dialog_context_menu_sample/dialog_widget.dart'
    as all_dialog_context_menu_sample;
import 'package:flutter_project_template/dialogs/all/all_dialog_context_menu_sample/dialog_widget_business.dart'
    as all_dialog_context_menu_sample_business;
import 'package:flutter_project_template/dialogs/all/all_dialog_stateful_and_lifecycle_test/dialog_widget.dart'
    as all_dialog_stateful_and_lifecycle_test;
import 'package:flutter_project_template/dialogs/all/all_dialog_stateful_and_lifecycle_test/dialog_widget_business.dart'
    as all_dialog_stateful_and_lifecycle_test_business;

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

  void onDialogTemplateItemClicked() {
    // (템플릿 다이얼로그 호출)
    final GlobalKey<all_dialog_template.MainWidgetState>
        allDialogTemplateStateGk = GlobalKey();

    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_template.MainWidget(
              key: allDialogTemplateStateGk,
              inputVo: all_dialog_template.InputVo(onDialogCreated: () {}),
            )).then((outputVo) {});
  }

  void onInfoDialogItemClicked() {
    // (확인 다이얼로그 호출)
    final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
        GlobalKey<all_dialog_info.MainWidgetState>();
    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_info.MainWidget(
              key: allDialogInfoStateGk,
              inputVo: all_dialog_info.InputVo(
                dialogTitle: "확인 다이얼로그",
                dialogContent: "확인 다이얼로그를 호출했습니다.",
                checkBtnTitle: "확인",
                onDialogCreated: () {},
              ),
            )).then((outputVo) {});
  }

  void onYesOrNoDialogItemClicked() {
    // (선택 다이얼로그 호출)
    final all_dialog_yes_or_no_business.DialogWidgetBusiness
        allDialogYesOrNoBusiness =
        all_dialog_yes_or_no_business.DialogWidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_yes_or_no.DialogWidget(
              business: allDialogYesOrNoBusiness,
              inputVo: const all_dialog_yes_or_no.InputVo(
                  dialogTitle: "예/아니오 다이얼로그",
                  dialogContent: "예/아니오 다이얼로그를 호출했습니다.\n예, 혹은 아니오 버튼을 누르세요.",
                  positiveBtnTitle: "예",
                  negativeBtnTitle: "아니오"),
              onDialogCreated: () {},
            )).then((outputVo) {
      if (outputVo == null) {
        // 아무것도 누르지 않았을 때
        showToast(
          "아무것도 누르지 않았습니다.",
          context: viewModel.context,
          animation: StyledToastAnimation.scale,
        );
      } else if (!outputVo.checkPositiveBtn) {
        // negative 버튼을 눌렀을 때
        showToast(
          "아니오 선택",
          context: viewModel.context,
          animation: StyledToastAnimation.scale,
        );
      } else {
        // positive 버튼을 눌렀을 때
        showToast(
          "예 선택",
          context: viewModel.context,
          animation: StyledToastAnimation.scale,
        );
      }
    });
  }

  void onLoadingSpinnerDialogItemClicked() {
    // (로딩 스피너 다이얼로그 호출)
    all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: viewModel.context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});

    // 3초 후 닫힘
    Future.delayed(const Duration(seconds: 2)).then((value) {
      allDialogLoadingSpinnerBusiness.closeDialog();
    });
  }

  void onBottomSheetModalDialogItemClicked() {
    // Bottom Sheet 다이얼로그 테스트
    // 일반 다이얼로그 위젯에 호출만 showModalBottomSheet 로 하면 됩니다.
    // BS 다이얼로그는 무조건 width 가 Max 입니다.

    final all_dialog_modal_bottom_sheet_sample_business.DialogWidgetBusiness
        allDialogModalBottomSheetSampleBusiness =
        all_dialog_modal_bottom_sheet_sample_business.DialogWidgetBusiness();

    showModalBottomSheet<void>(
      constraints: const BoxConstraints(minWidth: double.infinity),
      context: viewModel.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      // 슬라이드 가능여부
      builder: (context) => all_dialog_modal_bottom_sheet_sample.DialogWidget(
        business: allDialogModalBottomSheetSampleBusiness,
        inputVo: const all_dialog_modal_bottom_sheet_sample.InputVo(),
        onDialogCreated: () {},
      ),
    ).then((outputVo) {});
  }

  void onDialogInDialogItemClicked() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    final all_dialog_dialog_in_dialog_business.DialogWidgetBusiness
        allDialogDialogInDialogViewBusiness =
        all_dialog_dialog_in_dialog_business.DialogWidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_dialog_in_dialog.DialogWidget(
              business: allDialogDialogInDialogViewBusiness,
              inputVo: const all_dialog_dialog_in_dialog.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

  void onDialogBackgroundColorItemClicked() {
    // 다이얼로그 외부 색 설정
    final GlobalKey<all_dialog_template.MainWidgetState>
        allDialogTemplateStateGk = GlobalKey();

    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        barrierColor: Colors.blue.withOpacity(0.5),
        builder: (context) => all_dialog_template.MainWidget(
              key: allDialogTemplateStateGk,
              inputVo: all_dialog_template.InputVo(onDialogCreated: () {}),
            )).then((outputVo) {});
  }

  void onContextMenuDialogItemClicked() {
    final all_dialog_context_menu_sample_business.DialogWidgetBusiness
        allDialogContextMenuSampleBusiness =
        all_dialog_context_menu_sample_business.DialogWidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) => all_dialog_context_menu_sample.DialogWidget(
              business: allDialogContextMenuSampleBusiness,
              inputVo: const all_dialog_context_menu_sample.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

  void onDialogStatefulAndLifecycleTestItemClicked() {
    // 다이얼로그 생명주기 샘플
    final all_dialog_stateful_and_lifecycle_test_business.DialogWidgetBusiness
        allDialogStatefulAndLifecycleTestBusiness =
        all_dialog_stateful_and_lifecycle_test_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: true,
        context: viewModel.context,
        builder: (context) =>
            all_dialog_stateful_and_lifecycle_test.DialogWidget(
              business: allDialogStatefulAndLifecycleTestBusiness,
              inputVo: const all_dialog_stateful_and_lifecycle_test.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
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
  final GlobalKey<gw_do_delete.SfwListViewBuilderState>
      sfwListViewBuilderStateGk = GlobalKey();
}
