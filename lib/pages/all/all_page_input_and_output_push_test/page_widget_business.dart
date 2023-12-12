// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_gc_delete.dart'
    as gc_template_classes;
import 'package:flutter_project_template/pages/all/all_page_home/main_widget.dart'
    as all_page_home;

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
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!

    showToast(
      "inputValue : ${inputVo.inputValueString}\n"
      "inputValueOpt : ${inputVo.inputValueStringOpt}\n"
      "inputValueList : ${inputVo.inputValueStringList}\n"
      "inputValueInt : ${inputVo.inputValueInt}",
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.scale,
    );
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
    if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
      showToast(
        "inputValueString 은 필수입니다.",
        context: context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        context.pop();
      } else {
        // History가 없는 경우,
        // 홈 페이지로 이동
        context.goNamed(all_page_home.pageName);
      }
    }

    if (!goRouterState.uri.queryParameters
        .containsKey("inputValueStringList")) {
      showToast(
        "inputValueStringList 는 필수입니다.",
        context: context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        context.pop();
      } else {
        // History가 없는 경우,
        // 홈 페이지로 이동
        context.goNamed(all_page_home.pageName);
      }
    }

    if (!goRouterState.uri.queryParameters.containsKey("inputValueInt")) {
      showToast(
        "inputValueInt 는 필수입니다.",
        context: context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        context.pop();
      } else {
        // History가 없는 경우,
        // 홈 페이지로 이동
        context.goNamed(all_page_home.pageName);
      }
    }

    // !!!PageInputVo 입력!!!
    inputVo = page_widget.InputVo(
        inputValueString:
            goRouterState.uri.queryParameters["inputValueString"]!,
        inputValueStringOpt:
            goRouterState.uri.queryParameters["inputValueStringOpt"],
        inputValueStringList:
            goRouterState.uri.queryParametersAll["inputValueStringList"]!,
        inputValueInt:
            int.parse(goRouterState.uri.queryParameters["inputValueInt"]!));
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
  gc_template_classes.RefreshableBloc input1TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (값 반환 버튼 클릭시)
  void onPressedReturnBtn() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      context.pop();
    } else {
      context.pop(page_widget.OutputVo(resultValue: input1Text));
    }
  }

// [private 함수]
}
