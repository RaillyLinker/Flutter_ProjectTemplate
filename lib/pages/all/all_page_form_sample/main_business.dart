// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;

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
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
    input1TextFieldController.dispose();
    input1TextFieldFocus.dispose();
    input2TextFieldController.dispose();
    input2TextFieldFocus.dispose();
    input3TextFieldController.dispose();
    input3TextFieldFocus.dispose();
    input4TextFieldController.dispose();
    input4TextFieldFocus.dispose();
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

  // (input1TextField)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input1TextFieldAreaGk =
      GlobalKey();
  late BuildContext input1TextFieldContext;
  final TextEditingController input1TextFieldController =
      TextEditingController();
  final FocusNode input1TextFieldFocus = FocusNode();
  String? input1TextFieldErrorMsg;

  // (input2TextField)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input2TextFieldAreaGk =
      GlobalKey();
  late BuildContext input2TextFieldContext;
  final TextEditingController input2TextFieldController =
      TextEditingController();
  final FocusNode input2TextFieldFocus = FocusNode();
  String? input2TextFieldErrorMsg;

  // (input3TextField)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input3TextFieldAreaGk =
      GlobalKey();
  late BuildContext input3TextFieldContext;
  final TextEditingController input3TextFieldController =
      TextEditingController();
  final FocusNode input3TextFieldFocus = FocusNode();
  String? input3TextFieldErrorMsg;

  // (input4TextField)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input4TextFieldAreaGk =
      GlobalKey();
  late BuildContext input4TextFieldContext;
  final TextEditingController input4TextFieldController =
      TextEditingController();
  final FocusNode input4TextFieldFocus = FocusNode();
  String? input4TextFieldErrorMsg;
  bool input4TextFieldHide = true;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (input1 입력창에서 엔터를 쳤을 때의 콜백)
  void input1StateEntered() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input1TextFieldAreaGk.currentState?.refreshUi();
      return;
    }
    FocusScope.of(input2TextFieldContext).requestFocus(input2TextFieldFocus);
  }

  // (input2 입력창에서 엔터를 쳤을 때의 콜백)
  void input2StateEntered() {
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input2TextFieldAreaGk.currentState?.refreshUi();
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '영문 / 숫자를 16자 입력 하세요.';
      input2TextFieldAreaGk.currentState?.refreshUi();
      return;
    }
    FocusScope.of(input3TextFieldContext).requestFocus(input3TextFieldFocus);
  }

  // (input3 입력창에서 엔터를 쳤을 때의 콜백)
  void input3StateEntered() {
    String input3Text = input3TextFieldController.text;
    if (input3Text.isEmpty) {
      input3TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input3TextFieldAreaGk.currentState?.refreshUi();
      return;
    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(input3Text)) {
      input3TextFieldErrorMsg = '숫자를 16자 이내에 입력 하세요.';
      input3TextFieldAreaGk.currentState?.refreshUi();
      return;
    }
    FocusScope.of(input4TextFieldContext).requestFocus(input4TextFieldFocus);
  }

  // (input4 입력창에서 엔터를 쳤을 때의 콜백)
  void input4StateEntered() {
    String input4Text = input4TextFieldController.text;
    if (input4Text.isEmpty) {
      input4TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input4TextFieldAreaGk.currentState?.refreshUi();
      return;
    }
    completeTestForm();
  }

  void completeTestForm() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input1TextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(input1TextFieldContext).requestFocus(input1TextFieldFocus);
      return;
    }
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input2TextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(input2TextFieldContext).requestFocus(input2TextFieldFocus);
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '영문 / 숫자를 16자 입력 하세요.';
      input2TextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(input2TextFieldContext).requestFocus(input2TextFieldFocus);
      return;
    }
    String input3Text = input3TextFieldController.text;
    if (input3Text.isEmpty) {
      input3TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input3TextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(input3TextFieldContext).requestFocus(input3TextFieldFocus);
      return;
    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(input3Text)) {
      input3TextFieldErrorMsg = '숫자를 16자 이내에 입력 하세요.';
      input3TextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(input3TextFieldContext).requestFocus(input3TextFieldFocus);
      return;
    }
    String input4Text = input4TextFieldController.text;
    if (input4Text.isEmpty) {
      input4TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input4TextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(input4TextFieldContext).requestFocus(input4TextFieldFocus);
      return;
    }

    String input1 = input1Text;
    String input2 = input2Text;
    String input3 = input3Text;
    String input4 = input4Text;

    final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
        GlobalKey<all_dialog_info.MainWidgetState>();
    showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => all_dialog_info.MainWidget(
              key: allDialogInfoStateGk,
              inputVo: all_dialog_info.InputVo(
                dialogTitle: "폼 입력 결과",
                dialogContent: "입력1 : $input1\n"
                    "입력2 : $input2\n"
                    "입력3 : $input3\n"
                    "입력4 : $input4",
                checkBtnTitle: "확인",
                onDialogCreated: () {},
              ),
            ));
  }

  // [private 함수]
  void _doNothing() {}
}
