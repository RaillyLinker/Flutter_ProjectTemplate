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
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;

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

    input5TextFieldController.dispose();
    input5TextFieldFocus.dispose();

    input6TextFieldController.dispose();
    input6TextFieldFocus.dispose();

    for (Input9ListItemViewModel input9ListItem in input9List) {
      input9ListItem.inputTextFieldController.dispose();
      input9ListItem.inputTextFieldFocus.dispose();
    }

    for (Input10ListItemViewModel input10ListItem in input10List) {
      input10ListItem.inputTextFieldController.dispose();
      input10ListItem.inputTextFieldFocus.dispose();
    }
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
      TextEditingController()..text = "testString";
  final FocusNode input1TextFieldFocus = FocusNode();
  String? input1TextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input2TextFieldAreaGk =
      GlobalKey();
  late BuildContext input2TextFieldContext;
  final TextEditingController input2TextFieldController =
      TextEditingController();
  final FocusNode input2TextFieldFocus = FocusNode();
  String? input2TextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input3TextFieldAreaGk =
      GlobalKey();
  late BuildContext input3TextFieldContext;
  final TextEditingController input3TextFieldController =
      TextEditingController()..text = "1";
  final FocusNode input3TextFieldFocus = FocusNode();
  String? input3TextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input4TextFieldAreaGk =
      GlobalKey();
  late BuildContext input4TextFieldContext;
  final TextEditingController input4TextFieldController =
      TextEditingController();
  final FocusNode input4TextFieldFocus = FocusNode();
  String? input4TextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input5TextFieldAreaGk =
      GlobalKey();
  late BuildContext input5TextFieldContext;
  final TextEditingController input5TextFieldController =
      TextEditingController()..text = "1.0";
  final FocusNode input5TextFieldFocus = FocusNode();
  String? input5TextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input6TextFieldAreaGk =
      GlobalKey();
  late BuildContext input6TextFieldContext;
  final TextEditingController input6TextFieldController =
      TextEditingController();
  final FocusNode input6TextFieldFocus = FocusNode();
  String? input6TextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input7TextFieldAreaGk =
      GlobalKey();
  late BuildContext input7TextFieldContext;
  bool input7Value = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> input8TextFieldAreaGk =
      GlobalKey();
  late BuildContext input8TextFieldContext;
  bool? input8Value;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      input9TextFieldListAreaGk = GlobalKey();
  late BuildContext input9TextFieldListContext;
  List<Input9ListItemViewModel> input9List = [Input9ListItemViewModel()];

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      input10TextFieldListAreaGk = GlobalKey();
  late BuildContext input10TextFieldListContext;
  List<Input10ListItemViewModel> input10List = [];

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (리스트 파라미터 추가)
  void addInput9ListItem() {
    input9List.add(Input9ListItemViewModel());
    input9TextFieldListAreaGk.currentState?.refreshUi();
  }

  // (리스트 파라미터 제거)
  void deleteInput9ListItem(int idx) {
    var input9Item = input9List[idx];
    input9Item.inputTextFieldController.dispose();
    input9Item.inputTextFieldFocus.dispose();
    input9List.removeAt(idx);
    input9TextFieldListAreaGk.currentState?.refreshUi();
  }

  // (리스트 파라미터 추가)
  void addInput10ListItem() {
    input10List.add(Input10ListItemViewModel());
    input10TextFieldListAreaGk.currentState?.refreshUi();
  }

  // (리스트 파라미터 제거)
  void deleteInput10ListItem(int idx) {
    var input10Item = input10List[idx];
    input10Item.inputTextFieldController.dispose();
    input10Item.inputTextFieldFocus.dispose();
    input10List.removeAt(idx);
    input10TextFieldListAreaGk.currentState?.refreshUi();
  }

  // (네트워크 리퀘스트)
  Future<void> doNetworkRequest() async {
    // 로딩 다이얼로그 표시
    GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: mainContext,
        builder: (context) => all_dialog_loading_spinner.MainWidget(
              key: allDialogLoadingSpinnerStateGk,
              inputVo:
                  all_dialog_loading_spinner.InputVo(onDialogCreated: () async {
                String input1Text = input1TextFieldController.text;
                if (input1Text.isEmpty) {
                  // 로딩 다이얼로그 제거
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
                  input1TextFieldErrorMsg = '이 항목을 입력 하세요.';
                  input1TextFieldAreaGk.currentState?.refreshUi();
                  FocusScope.of(input1TextFieldContext)
                      .requestFocus(input1TextFieldFocus);
                  return;
                }

                String input3Text = input3TextFieldController.text;
                if (input3Text.isEmpty) {
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
                  input3TextFieldErrorMsg = '이 항목을 입력 하세요.';
                  input3TextFieldAreaGk.currentState?.refreshUi();
                  FocusScope.of(input3TextFieldContext)
                      .requestFocus(input3TextFieldFocus);
                  return;
                }

                String input5Text = input5TextFieldController.text;
                if (input5Text.isEmpty) {
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
                  input5TextFieldErrorMsg = '이 항목을 입력 하세요.';
                  input5TextFieldAreaGk.currentState?.refreshUi();
                  FocusScope.of(input5TextFieldContext)
                      .requestFocus(input5TextFieldFocus);
                  return;
                }

                List<String> requestFormStringList = [];
                for (Input9ListItemViewModel tec in input9List) {
                  String value = tec.inputTextFieldController.text;
                  if (value.isEmpty) {
                    allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                        .closeDialog();
                    tec.inputTextFieldErrorMsg = '이 항목을 입력 하세요.';
                    tec.inputTextFieldAreaGk.currentState?.refreshUi();
                    FocusScope.of(tec.inputTextFieldContext)
                        .requestFocus(tec.inputTextFieldFocus);
                    return;
                  }
                  requestFormStringList.add(value);
                }

                List<String>? requestFormStringListNullable;
                if (input10List.isNotEmpty) {
                  requestFormStringListNullable = [];
                  for (Input10ListItemViewModel tec in input10List) {
                    String value = tec.inputTextFieldController.text;
                    if (value.isEmpty) {
                      allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                          .closeDialog();
                      tec.inputTextFieldErrorMsg = '이 항목을 입력 하세요.';
                      tec.inputTextFieldAreaGk.currentState?.refreshUi();
                      FocusScope.of(tec.inputTextFieldContext)
                          .requestFocus(tec.inputTextFieldFocus);
                      return;
                    }
                    requestFormStringListNullable.add(value);
                  }
                }

                var response = await api_main_server
                    .postService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsync(
                        requestBodyVo: api_main_server
                            .PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncRequestBodyVo(
                                requestFormString: input1Text,
                                requestFormStringNullable:
                                    (input2TextFieldController.text == "")
                                        ? null
                                        : input2TextFieldController.text,
                                requestFormInt: int.parse(input3Text),
                                requestFormIntNullable:
                                    (input4TextFieldController.text == "")
                                        ? null
                                        : int.parse(
                                            input4TextFieldController.text),
                                requestFormDouble: double.parse(input5Text),
                                requestFormDoubleNullable:
                                    (input6TextFieldController.text == "")
                                        ? null
                                        : double.parse(
                                            input6TextFieldController.text),
                                requestFormBoolean: input7Value,
                                requestFormBooleanNullable: input8Value,
                                requestFormStringList: requestFormStringList,
                                requestFormStringListNullable:
                                    requestFormStringListNullable));

                // 로딩 다이얼로그 제거
                allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                    .closeDialog();

                if (response.dioException == null) {
                  // Dio 네트워크 응답

                  var networkResponseObjectOk =
                      response.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    // 정상 응답

                    // 응답 body
                    var responseBody = networkResponseObjectOk.responseBody
                        as api_main_server
                        .PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo;

                    // 확인 다이얼로그 호출
                    final GlobalKey<all_dialog_info.MainWidgetState>
                        allDialogInfoStateGk =
                        GlobalKey<all_dialog_info.MainWidgetState>();
                    if (!context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => all_dialog_info.MainWidget(
                              key: allDialogInfoStateGk,
                              inputVo: all_dialog_info.InputVo(
                                dialogTitle: "응답 결과",
                                dialogContent:
                                    "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                                checkBtnTitle: "확인",
                                onDialogCreated: () {},
                              ),
                            )).then((outputVo) {});
                  } else {
                    // 비정상 응답
                    final GlobalKey<all_dialog_info.MainWidgetState>
                        allDialogInfoStateGk =
                        GlobalKey<all_dialog_info.MainWidgetState>();
                    if (!context.mounted) return;
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => all_dialog_info.MainWidget(
                              key: allDialogInfoStateGk,
                              inputVo: all_dialog_info.InputVo(
                                dialogTitle: "네트워크 에러",
                                dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                                checkBtnTitle: "확인",
                                onDialogCreated: () {},
                              ),
                            ));
                  }
                } else {
                  // Dio 네트워크 에러
                  final GlobalKey<all_dialog_info.MainWidgetState>
                      allDialogInfoStateGk =
                      GlobalKey<all_dialog_info.MainWidgetState>();
                  if (!context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => all_dialog_info.MainWidget(
                            key: allDialogInfoStateGk,
                            inputVo: all_dialog_info.InputVo(
                              dialogTitle: "네트워크 에러",
                              dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                              checkBtnTitle: "확인",
                              onDialogCreated: () {},
                            ),
                          ));
                }
              }),
            )).then((outputVo) {});
  }

  // [private 함수]
  void _doNothing() {}
}

class Input9ListItemViewModel {
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> inputTextFieldAreaGk =
      GlobalKey();
  late BuildContext inputTextFieldContext;
  final TextEditingController inputTextFieldController = TextEditingController()
    ..text = "testString";
  final FocusNode inputTextFieldFocus = FocusNode();
  String? inputTextFieldErrorMsg;
}

class Input10ListItemViewModel {
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> inputTextFieldAreaGk =
      GlobalKey();
  late BuildContext inputTextFieldContext;
  final TextEditingController inputTextFieldController = TextEditingController()
    ..text = "testString";
  final FocusNode inputTextFieldFocus = FocusNode();
  String? inputTextFieldErrorMsg;
}
