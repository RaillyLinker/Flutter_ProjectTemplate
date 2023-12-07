// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_state.dart'
    as all_dialog_info_state;
import '../../../a_templates/all_dialog_template/dialog_widget.dart'
    as all_dialog_template_view;
import '../../../a_templates/all_dialog_template/dialog_widget_state.dart'
    as all_dialog_template_state;
import '../../../dialogs/all/all_dialog_yes_or_no/dialog_widget.dart'
    as all_dialog_yes_or_no;
import '../../../dialogs/all/all_dialog_yes_or_no/dialog_widget_state.dart'
    as all_dialog_yes_or_no_state;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_state.dart'
    as all_dialog_loading_spinner_state;
import '../../../dialogs/all/all_dialog_modal_bottom_sheet_sample/dialog_widget.dart'
    as all_dialog_modal_bottom_sheet_sample;
import '../../../dialogs/all/all_dialog_modal_bottom_sheet_sample/dialog_widget_state.dart'
    as all_dialog_modal_bottom_sheet_sample_state;
import '../../../dialogs/all/all_dialog_dialog_in_dialog/dialog_widget.dart'
    as all_dialog_dialog_in_dialog;
import '../../../dialogs/all/all_dialog_dialog_in_dialog/dialog_widget_state.dart'
    as all_dialog_dialog_in_dialog_state;
import '../../../dialogs/all/all_dialog_context_menu_sample/dialog_widget.dart'
    as all_dialog_context_menu_sample;
import '../../../dialogs/all/all_dialog_context_menu_sample/dialog_widget_state.dart'
    as all_dialog_context_menu_sample_state;
import '../../../dialogs/all/all_dialog_lifecycle_sample/dialog_widget.dart'
    as all_dialog_lifecycle_sample;
import '../../../dialogs/all/all_dialog_lifecycle_sample/dialog_widget_state.dart'
    as all_dialog_lifecycle_sample_state;

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

    setListItem();
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

  List<SampleItemViewModel> itemList = [];
  gc_template_classes.RefreshableBloc itemListBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void setListItem() {
    itemList = [];
    itemList.add(SampleItemViewModel(
        itemTitle: "다이얼로그 템플릿",
        itemDescription: "템플릿 다이얼로그를 호출합니다.",
        onItemClicked: () {
          // (템플릿 다이얼로그 호출)
          var dialogGk =
              GlobalKey<all_dialog_template_state.DialogWidgetState>();

          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_template_view.DialogWidget(
                    globalKey: dialogGk,
                    inputVo: const all_dialog_template_view.InputVo(),
                    onDialogCreated: () {},
                  )).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "확인 다이얼로그",
        itemDescription: "버튼이 하나인 확인 다이얼로그를 호출합니다.",
        onItemClicked: () {
          // (확인 다이얼로그 호출)
          final GlobalKey<all_dialog_info_state.DialogWidgetState>
              allDialogInfoGk = GlobalKey();
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_info.DialogWidget(
                    globalKey: allDialogInfoGk,
                    inputVo: const all_dialog_info.InputVo(
                        dialogTitle: "확인 다이얼로그",
                        dialogContent: "확인 다이얼로그를 호출했습니다.",
                        checkBtnTitle: "확인"),
                    onDialogCreated: () {},
                  )).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "예/아니오 다이얼로그",
        itemDescription: "버튼이 두개인 다이얼로그를 호출합니다.",
        onItemClicked: () {
          // (선택 다이얼로그 호출)
          GlobalKey<all_dialog_yes_or_no_state.DialogWidgetState>
              allDialogYesOrNoBusiness = GlobalKey();
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_yes_or_no.DialogWidget(
                    globalKey: allDialogYesOrNoBusiness,
                    inputVo: const all_dialog_yes_or_no.InputVo(
                        dialogTitle: "예/아니오 다이얼로그",
                        dialogContent:
                            "예/아니오 다이얼로그를 호출했습니다.\n예, 혹은 아니오 버튼을 누르세요.",
                        positiveBtnTitle: "예",
                        negativeBtnTitle: "아니오"),
                    onDialogCreated: () {},
                  )).then((outputVo) {
            if (outputVo == null) {
              // 아무것도 누르지 않았을 때
              showToast(
                "아무것도 누르지 않았습니다.",
                context: context,
                animation: StyledToastAnimation.scale,
              );
            } else if (!outputVo.checkPositiveBtn) {
              // negative 버튼을 눌렀을 때
              showToast(
                "아니오 선택",
                context: context,
                animation: StyledToastAnimation.scale,
              );
            } else {
              // positive 버튼을 눌렀을 때
              showToast(
                "예 선택",
                context: context,
                animation: StyledToastAnimation.scale,
              );
            }
          });
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "로딩 스피너 다이얼로그",
        itemDescription: "로딩 스피너 다이얼로그를 호출하고 2초 후 종료합니다.",
        onItemClicked: () {
          // (로딩 스피너 다이얼로그 호출)
          GlobalKey<all_dialog_loading_spinner_state.DialogWidgetState>
              allDialogLoadingSpinnerStateGk = GlobalKey();

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => all_dialog_loading_spinner.DialogWidget(
                  globalKey: allDialogLoadingSpinnerStateGk,
                  inputVo: const all_dialog_loading_spinner.InputVo(),
                  onDialogCreated: () {})).then((outputVo) {});

          // 3초 후 닫힘
          Future.delayed(const Duration(seconds: 2)).then((value) {
            allDialogLoadingSpinnerStateGk.currentState?.closeDialog();
          });
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "아래에 붙은 다이얼로그",
        itemDescription: "아래에서 올라오는 다이얼로그를 호출합니다.",
        onItemClicked: () {
          // Bottom Sheet 다이얼로그 테스트
          // 일반 다이얼로그 위젯에 호출만 showModalBottomSheet 로 하면 됩니다.
          // BS 다이얼로그는 무조건 width 가 Max 입니다.

          final GlobalKey<
                  all_dialog_modal_bottom_sheet_sample_state.DialogWidgetState>
              allDialogModalBottomSheetSampleGk = GlobalKey();

          showModalBottomSheet<void>(
            constraints: const BoxConstraints(minWidth: double.infinity),
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            // 슬라이드 가능여부
            builder: (context) =>
                all_dialog_modal_bottom_sheet_sample.DialogWidget(
              globalKey: allDialogModalBottomSheetSampleGk,
              inputVo: const all_dialog_modal_bottom_sheet_sample.InputVo(),
              onDialogCreated: () {},
            ),
          ).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "다이얼로그 속 다이얼로그",
        itemDescription: "다이얼로그에서 다이얼로그를 호출합니다.",
        onItemClicked: () {
          // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
          GlobalKey<all_dialog_dialog_in_dialog_state.DialogWidgetState>
              allDialogDialogInDialogViewState = GlobalKey();
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_dialog_in_dialog.DialogWidget(
                    globalKey: allDialogDialogInDialogViewState,
                    inputVo: const all_dialog_dialog_in_dialog.InputVo(),
                    onDialogCreated: () {},
                  )).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "다이얼로그 외부 색 설정",
        itemDescription: "다이얼로그 영역 바깥의 색상을 지정합니다.",
        onItemClicked: () {
          // 다이얼로그 외부 색 설정
          var dialogGk =
              GlobalKey<all_dialog_template_state.DialogWidgetState>();

          showDialog(
              barrierDismissible: true,
              context: context,
              barrierColor: Colors.blue.withOpacity(0.5),
              builder: (context) => all_dialog_template_view.DialogWidget(
                    globalKey: dialogGk,
                    inputVo: const all_dialog_template_view.InputVo(),
                    onDialogCreated: () {},
                  )).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "컨텍스트 메뉴 샘플",
        itemDescription: "다이얼로그에서 컨텍스트 메뉴를 사용하는 샘플",
        onItemClicked: () {
          GlobalKey<all_dialog_context_menu_sample_state.DialogWidgetState>
              allDialogContextMenuSampleState = GlobalKey();
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_context_menu_sample.DialogWidget(
                    globalKey: allDialogContextMenuSampleState,
                    inputVo: const all_dialog_context_menu_sample.InputVo(),
                    onDialogCreated: () {},
                  )).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "다이얼로그 생명주기 샘플",
        itemDescription: "다이얼로그에서의 생명주기를 확인하는 샘플",
        onItemClicked: () {
          // 다이얼로그 생명주기 샘플
          final GlobalKey<all_dialog_lifecycle_sample_state.DialogWidgetState>
              lifecycleSampleBusinessGk = GlobalKey();

          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_lifecycle_sample.DialogWidget(
                    globalKey: lifecycleSampleBusinessGk,
                    inputVo: const all_dialog_lifecycle_sample.InputVo(),
                    onDialogCreated: () {},
                  )).then((outputVo) {});
        }));

    itemListBloc.refreshUi();
  }

// [private 함수]
}

class SampleItemViewModel {
  SampleItemViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // 샘플 타이틀
  final String itemTitle;

  // 샘플 설명
  final String itemDescription;

  final void Function() onItemClicked;

  bool isHovering = false;
  gc_template_classes.RefreshableBloc isHoveringBloc =
      gc_template_classes.RefreshableBloc();
}
