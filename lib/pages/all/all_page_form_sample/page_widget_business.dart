// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_do_delete.dart'
    as todo_do_delete;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;

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
    input1TextFieldController.dispose();
    input1TextFieldFocus.dispose();
    input2TextFieldController.dispose();
    input2TextFieldFocus.dispose();
    input3TextFieldController.dispose();
    input3TextFieldFocus.dispose();
    input4TextFieldController.dispose();
    input4TextFieldFocus.dispose();
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

  // (input1TextField)
  final TextEditingController input1TextFieldController =
      TextEditingController();
  final FocusNode input1TextFieldFocus = FocusNode();
  String? input1TextFieldErrorMsg;
  todo_do_delete.RefreshableBloc input1TextFieldBloc =
      todo_do_delete.RefreshableBloc();

  // (input2TextField)
  final TextEditingController input2TextFieldController =
      TextEditingController();
  final FocusNode input2TextFieldFocus = FocusNode();
  String? input2TextFieldErrorMsg;
  todo_do_delete.RefreshableBloc input2TextFieldBloc =
      todo_do_delete.RefreshableBloc();

  // (input3TextField)
  final TextEditingController input3TextFieldController =
      TextEditingController();
  final FocusNode input3TextFieldFocus = FocusNode();
  String? input3TextFieldErrorMsg;
  todo_do_delete.RefreshableBloc input3TextFieldBloc =
      todo_do_delete.RefreshableBloc();

  // (input4TextField)
  final TextEditingController input4TextFieldController =
      TextEditingController();
  final FocusNode input4TextFieldFocus = FocusNode();
  String? input4TextFieldErrorMsg;
  todo_do_delete.RefreshableBloc input4TextFieldBloc =
      todo_do_delete.RefreshableBloc();
  bool input4TextFieldHide = true;

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (input1 입력창에서 엔터를 쳤을 때의 콜백)
  void input1StateEntered() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input1TextFieldBloc.refreshUi();
      return;
    }
    FocusScope.of(context).requestFocus(input2TextFieldFocus);
  }

  // (input2 입력창에서 엔터를 쳤을 때의 콜백)
  void input2StateEntered() {
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input2TextFieldBloc.refreshUi();
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '영문 / 숫자를 16자 입력 하세요.';
      input2TextFieldBloc.refreshUi();
      return;
    }
    FocusScope.of(context).requestFocus(input3TextFieldFocus);
  }

  // (input3 입력창에서 엔터를 쳤을 때의 콜백)
  void input3StateEntered() {
    String input3Text = input3TextFieldController.text;
    if (input3Text.isEmpty) {
      input3TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input3TextFieldBloc.refreshUi();
      return;
    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(input3Text)) {
      input3TextFieldErrorMsg = '숫자를 16자 이내에 입력 하세요.';
      input3TextFieldBloc.refreshUi();
      return;
    }
    FocusScope.of(context).requestFocus(input4TextFieldFocus);
  }

  // (input4 입력창에서 엔터를 쳤을 때의 콜백)
  void input4StateEntered() {
    String input4Text = input4TextFieldController.text;
    if (input4Text.isEmpty) {
      input4TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input4TextFieldBloc.refreshUi();
      return;
    }
    completeTestForm();
  }

  void completeTestForm() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input1TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    }
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input2TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input2TextFieldFocus);
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '영문 / 숫자를 16자 입력 하세요.';
      input2TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input2TextFieldFocus);
      return;
    }
    String input3Text = input3TextFieldController.text;
    if (input3Text.isEmpty) {
      input3TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input3TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input3TextFieldFocus);
      return;
    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(input3Text)) {
      input3TextFieldErrorMsg = '숫자를 16자 이내에 입력 하세요.';
      input3TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input3TextFieldFocus);
      return;
    }
    String input4Text = input4TextFieldController.text;
    if (input4Text.isEmpty) {
      input4TextFieldErrorMsg = '이 항목을 입력 하세요.';
      input4TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input4TextFieldFocus);
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
        context: context,
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
}
