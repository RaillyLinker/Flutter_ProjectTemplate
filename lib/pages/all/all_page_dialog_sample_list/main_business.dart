// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/a_templates/all_dialog_template/main_widget.dart'
    as all_dialog_template;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/main_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/dialogs/all/all_dialog_modal_bottom_sheet_sample/main_widget.dart'
    as all_dialog_modal_bottom_sheet_sample;
import 'package:flutter_project_template/dialogs/all/all_dialog_dialog_in_dialog/main_widget.dart'
    as all_dialog_dialog_in_dialog;
import 'package:flutter_project_template/dialogs/all/all_dialog_context_menu_sample/main_widget.dart'
    as all_dialog_context_menu_sample;
import 'package:flutter_project_template/dialogs/all/all_dialog_stateful_and_lifecycle_test/main_widget.dart'
    as all_dialog_stateful_and_lifecycle_test;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (inputVo 확인 콜백)
  // State 클래스의 initState 에서 실행 되며, Business 클래스의 initState 실행 전에 실행 됩니다.
  // 필수 정보 누락시 null 을 반환, null 이 반환 되었을 때는 inputError 가 true 가 됩니다.
  main_widget.InputVo? onCheckPageInputVo(
      {required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
    hoveringTileViewModelList = getNewItemWidgetList();
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!
  }

  Future<void> onVisibilityGainedAsync() async {
    // !!!onVisibilityGainedAsync 로직 작성!!!
  }

  Future<void> onVisibilityLostAsync() async {
    // !!!onVisibilityLostAsync 로직 작성!!!
  }

  Future<void> onForegroundGainedAsync() async {
    // !!!onForegroundGainedAsync 로직 작성!!!
  }

  Future<void> onForegroundLostAsync() async {
    // !!!onForegroundLostAsync 로직 작성!!!
  }

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 변수는 이곳에서 저장하여 사용하세요.!!!
  // [public 변수]
  // (위젯 입력값)
  late main_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수) - false 로 설정시 pop 불가
  bool canPop = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      hoveringTileViewModelListAreaGk = GlobalKey();
  late BuildContext hoveringTileListAreaContext;
  List<HoveringListTileViewModel> hoveringTileViewModelList = [];

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (현 상황에 맞는 아이템 리스트 반환)
  List<HoveringListTileViewModel> getNewItemWidgetList() {
    List<HoveringListTileViewModel> hoveringListTileViewModel = [];
    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "다이얼로그 템플릿",
          itemDescription: "템플릿 다이얼로그를 호출합니다.",
          onItemClicked: () {
            // (템플릿 다이얼로그 호출)
            final GlobalKey<all_dialog_template.MainWidgetState>
                allDialogTemplateStateGk = GlobalKey();

            showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) => all_dialog_template.MainWidget(
                      key: allDialogTemplateStateGk,
                      inputVo:
                          all_dialog_template.InputVo(onDialogCreated: () {}),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "확인 다이얼로그",
          itemDescription: "버튼이 하나인 확인 다이얼로그를 호출합니다.",
          onItemClicked: () {
            // (확인 다이얼로그 호출)
            final GlobalKey<all_dialog_info.MainWidgetState>
                allDialogInfoStateGk =
                GlobalKey<all_dialog_info.MainWidgetState>();
            showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) => all_dialog_info.MainWidget(
                      key: allDialogInfoStateGk,
                      inputVo: all_dialog_info.InputVo(
                        dialogTitle: "확인 다이얼로그",
                        dialogContent: "확인 다이얼로그를 호출했습니다.",
                        checkBtnTitle: "확인",
                        onDialogCreated: () {},
                      ),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "예/아니오 다이얼로그",
          itemDescription: "버튼이 두개인 다이얼로그를 호출합니다.",
          onItemClicked: () {
            // (선택 다이얼로그 호출)
            final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
                allDialogYesOrNoStateGk = GlobalKey();
            showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) => all_dialog_yes_or_no.MainWidget(
                      key: allDialogYesOrNoStateGk,
                      inputVo: all_dialog_yes_or_no.InputVo(
                        dialogTitle: "예/아니오 다이얼로그",
                        dialogContent:
                            "예/아니오 다이얼로그를 호출했습니다.\n예, 혹은 아니오 버튼을 누르세요.",
                        positiveBtnTitle: "예",
                        negativeBtnTitle: "아니오",
                        onDialogCreated: () {},
                      ),
                    )).then((outputVo) {
              if (outputVo == null) {
                // 아무것도 누르지 않았을 때
                showToast(
                  "아무것도 누르지 않았습니다.",
                  context: mainContext,
                  animation: StyledToastAnimation.scale,
                );
              } else if (!outputVo.checkPositiveBtn) {
                // negative 버튼을 눌렀을 때
                showToast(
                  "아니오 선택",
                  context: mainContext,
                  animation: StyledToastAnimation.scale,
                );
              } else {
                // positive 버튼을 눌렀을 때
                showToast(
                  "예 선택",
                  context: mainContext,
                  animation: StyledToastAnimation.scale,
                );
              }
            });
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "로딩 스피너 다이얼로그",
          itemDescription: "로딩 스피너 다이얼로그를 호출하고 2초 후 종료합니다.",
          onItemClicked: () {
            // (로딩 스피너 다이얼로그 호출)
            GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                allDialogLoadingSpinnerStateGk = GlobalKey();

            showDialog(
                barrierDismissible: false,
                context: mainContext,
                builder: (context) => all_dialog_loading_spinner.MainWidget(
                      key: allDialogLoadingSpinnerStateGk,
                      inputVo: all_dialog_loading_spinner.InputVo(
                          onDialogCreated: () {}),
                    )).then((outputVo) {});

            // 3초 후 닫힘
            Future.delayed(const Duration(seconds: 2)).then((value) {
              allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                  .closeDialog();
            });
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "아래에 붙은 다이얼로그",
          itemDescription: "아래에서 올라오는 다이얼로그를 호출합니다.",
          onItemClicked: () {
            // Bottom Sheet 다이얼로그 테스트
            // 일반 다이얼로그 위젯에 호출만 showModalBottomSheet 로 하면 됩니다.
            // BS 다이얼로그는 무조건 width 가 Max 입니다.

            final GlobalKey<
                    all_dialog_modal_bottom_sheet_sample.MainWidgetState>
                allDialogModalBottomSheetSampleAreaGk = GlobalKey();

            showModalBottomSheet<void>(
              constraints: const BoxConstraints(minWidth: double.infinity),
              context: mainContext,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              // 슬라이드 가능여부
              builder: (context) =>
                  all_dialog_modal_bottom_sheet_sample.MainWidget(
                key: allDialogModalBottomSheetSampleAreaGk,
                inputVo: all_dialog_modal_bottom_sheet_sample.InputVo(
                  onDialogCreated: () {},
                ),
              ),
            ).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "다이얼로그 속 다이얼로그",
          itemDescription: "다이얼로그에서 다이얼로그를 호출합니다.",
          onItemClicked: () {
            // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
            final GlobalKey<all_dialog_dialog_in_dialog.MainWidgetState>
                allDialogDialogInDialogViewStateGk = GlobalKey();
            showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) => all_dialog_dialog_in_dialog.MainWidget(
                      key: allDialogDialogInDialogViewStateGk,
                      inputVo: all_dialog_dialog_in_dialog.InputVo(
                        onDialogCreated: () {},
                      ),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "다이얼로그 외부 색 설정",
          itemDescription: "다이얼로그 영역 바깥의 색상을 지정합니다.",
          onItemClicked: () {
            // 다이얼로그 외부 색 설정
            final GlobalKey<all_dialog_template.MainWidgetState>
                allDialogTemplateStateGk = GlobalKey();

            showDialog(
                barrierDismissible: true,
                context: mainContext,
                barrierColor: Colors.blue.withOpacity(0.5),
                builder: (context) => all_dialog_template.MainWidget(
                      key: allDialogTemplateStateGk,
                      inputVo:
                          all_dialog_template.InputVo(onDialogCreated: () {}),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "컨텍스트 메뉴 샘플",
          itemDescription: "다이얼로그에서 컨텍스트 메뉴를 사용하는 샘플",
          onItemClicked: () {
            final GlobalKey<all_dialog_context_menu_sample.MainWidgetState>
                allDialogContextMenuSampleStateGk = GlobalKey();
            showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) => all_dialog_context_menu_sample.MainWidget(
                      key: allDialogContextMenuSampleStateGk,
                      inputVo: all_dialog_context_menu_sample.InputVo(
                        onDialogCreated: () {},
                      ),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "다이얼로그 Stateful 상태 및 생명주기 테스트",
          itemDescription: "다이얼로그 Stateful 상태 및 생명주기를 테스트 합니다.",
          onItemClicked: () {
            // 다이얼로그 생명주기 샘플
            final GlobalKey<
                    all_dialog_stateful_and_lifecycle_test.MainWidgetState>
                allDialogStatefulAndLifecycleTestAreaGk = GlobalKey();

            showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) =>
                    all_dialog_stateful_and_lifecycle_test.MainWidget(
                      key: allDialogStatefulAndLifecycleTestAreaGk,
                      inputVo: all_dialog_stateful_and_lifecycle_test.InputVo(
                        onDialogCreated: () {},
                      ),
                    )).then((outputVo) {});
          }),
    );

    return hoveringListTileViewModel;
  }

  // [private 함수]
  void _doNothing() {}
}

class HoveringListTileViewModel {
  HoveringListTileViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // [public 변수]
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> hoveringTileAreaGk =
      GlobalKey();
  late BuildContext hoveringTileAreaContext;
  bool isHovering = false;

  final String itemTitle;
  final String itemDescription;
  final void Function() onItemClicked;
}
