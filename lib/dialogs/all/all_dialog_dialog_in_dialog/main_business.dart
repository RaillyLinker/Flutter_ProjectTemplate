// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
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

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (onDialogCreated 실행 플래그)
  bool needCallOnDialogCreated = true;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    mainContext.pop();
  }

  // (Info 다이얼로그 호출)
  void showInfoDialog() {
    final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
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
  }

  // (Loading 다이얼로그 호출)
  void showLoadingDialog() {
    final GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => all_dialog_loading_spinner.MainWidget(
              key: allDialogLoadingSpinnerStateGk,
              inputVo:
                  all_dialog_loading_spinner.InputVo(onDialogCreated: () {}),
            )).then((outputVo) {});
  }

  // (현재 다이얼로그 다시 호출)
  void showDialogInDialog() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    final GlobalKey<main_widget.MainWidgetState>
        allDialogDialogInDialogStateGk = GlobalKey();
    showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => main_widget.MainWidget(
              key: allDialogDialogInDialogStateGk,
              inputVo: main_widget.InputVo(
                onDialogCreated: () {},
              ),
            )).then((outputVo) {});
  }

  // [private 함수]
  void _doNothing() {}
}
