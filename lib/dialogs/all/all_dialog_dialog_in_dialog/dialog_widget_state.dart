// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'dialog_widget.dart' as dialog_widget;

// (all)
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_state.dart'
    as all_dialog_loading_spinner_state;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_state.dart'
    as all_dialog_info_state;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class DialogWidgetState extends State<dialog_widget.DialogWidget>
    with WidgetsBindingObserver {
  DialogWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (needInitState) {
            needInitState = false;
            widget.onDialogCreated();
          }

          // !!!생명주기 처리!!!
        },
        onFocusLost: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityGained: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityLost: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundGained: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundLost: () async {
          // !!!생명주기 처리!!!
        },
        child: widget.widgetUiBuild(context: context, currentState: this),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.onDialogCreated();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (최초 실행 플래그)
  bool needInitState = true;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  // (Info 다이얼로그 호출)
  void showInfoDialog() {
    GlobalKey<all_dialog_info_state.DialogWidgetState> allDialogInfoGk =
        GlobalKey();
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
  }

  // (Loading 다이얼로그 호출)
  void showLoadingDialog() {
    GlobalKey<all_dialog_loading_spinner_state.DialogWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            globalKey: allDialogLoadingSpinnerStateGk,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});
  }

  // (현재 다이얼로그 다시 호출)
  void showDialogInDialog() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    GlobalKey<DialogWidgetState> allDialogDialogInDialogViewState = GlobalKey();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => dialog_widget.DialogWidget(
              globalKey: allDialogDialogInDialogViewState,
              inputVo: const dialog_widget.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }
}
