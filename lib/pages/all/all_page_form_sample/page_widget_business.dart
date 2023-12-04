// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_widgets/gw_text_form_field_wrapper/sf_widget_state.dart'
    as gw_text_form_field_wrapper_state;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_state.dart'
    as all_dialog_info_state;

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
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  final GlobalKey<gw_text_form_field_wrapper_state.SfWidgetState>
      input1StateGk = GlobalKey();

  final GlobalKey<gw_text_form_field_wrapper_state.SfWidgetState>
      input2StateGk = GlobalKey();

  final GlobalKey<gw_text_form_field_wrapper_state.SfWidgetState>
      input3StateGk = GlobalKey();

  final GlobalKey<gw_text_form_field_wrapper_state.SfWidgetState>
      input4StateGk = GlobalKey();

  bool input4StateHide = true;

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (input1 입력창 검사 콜백 - 에러가 있다면 에러 메세지 String 반환)
  String? input1StateValidator(String value) {
    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
    if (value.isEmpty) {
      return '이 항목을 입력 하세요.';
    }
    return null;
  }

  // (input1 입력창에서 엔터를 쳤을 때의 콜백)
  void input1StateEntered() {
    // 입력창 포커스 상태에서 엔터
    if (input1StateGk.currentState != null &&
        input1StateGk.currentState!.validate() == null) {
      input2StateGk.currentState?.requestFocus();
    }
  }

  // (input2 입력창 검사 콜백 - 에러가 있다면 에러 메세지 String 반환)
  String? input2StateValidator(String value) {
    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
    if (value.isEmpty) {
      return '이 항목을 입력 하세요.';
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(value)) {
      return '영문 / 숫자를 16자 입력 하세요.';
    } else {
      return null;
    }
  }

  // (input2 입력창에서 엔터를 쳤을 때의 콜백)
  void input2StateEntered() {
    // 입력창 포커스 상태에서 엔터
    if (input2StateGk.currentState != null &&
        input2StateGk.currentState!.validate() == null) {
      input3StateGk.currentState?.requestFocus();
    }
  }

  // (input3 입력창 검사 콜백 - 에러가 있다면 에러 메세지 String 반환)
  String? input3StateValidator(String value) {
    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
    if (value.isEmpty) {
      return '이 항목을 입력 하세요.';
    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(value)) {
      return '숫자를 16자 이내에 입력 하세요.';
    } else {
      return null;
    }
  }

  // (input3 입력창에서 엔터를 쳤을 때의 콜백)
  void input3StateEntered() {
    // 입력창 포커스 상태에서 엔터
    if (input3StateGk.currentState != null &&
        input3StateGk.currentState!.validate() == null) {
      input4StateGk.currentState?.requestFocus();
    }
  }

  // (input4 입력창 검사 콜백 - 에러가 있다면 에러 메세지 String 반환)
  String? input4StateValidator(String value) {
    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
    if (value.isEmpty) {
      return '이 항목을 입력 하세요.';
    }
    return null;
  }

  // (input4 입력창에서 엔터를 쳤을 때의 콜백)
  void input4StateEntered() {
    // 입력창 포커스 상태에서 엔터
    if (input4StateGk.currentState != null &&
        input4StateGk.currentState!.validate() == null) {
      completeTestForm();
    }
  }

  void completeTestForm() {
    if (input1StateGk.currentState == null ||
        input1StateGk.currentState!.validate() != null) {
      return;
    }

    if (input2StateGk.currentState == null ||
        input2StateGk.currentState!.validate() != null) {
      return;
    }

    if (input3StateGk.currentState == null ||
        input3StateGk.currentState!.validate() != null) {
      return;
    }

    if (input4StateGk.currentState == null ||
        input4StateGk.currentState!.validate() != null) {
      return;
    }

    String input1 = input1StateGk.currentState!.getInputValue();
    String input2 = input2StateGk.currentState!.getInputValue();
    String input3 = input3StateGk.currentState!.getInputValue();
    String input4 = input4StateGk.currentState!.getInputValue();

    final GlobalKey<all_dialog_info_state.DialogWidgetState> allDialogInfoGk =
        GlobalKey();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_info.DialogWidget(
              globalKey: allDialogInfoGk,
              inputVo: all_dialog_info.InputVo(
                dialogTitle: "폼 입력 결과",
                dialogContent: "입력1 : $input1\n"
                    "입력2 : $input2\n"
                    "입력3 : $input3\n"
                    "입력4 : $input4",
                checkBtnTitle: "확인",
              ),
              onDialogCreated: () {},
            ));
  }

// [private 함수]
}
