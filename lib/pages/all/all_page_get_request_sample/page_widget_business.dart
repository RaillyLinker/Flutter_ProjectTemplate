// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_classes/todo_gc_delete.dart'
    as gc_template_classes;
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/dialog_widget_business.dart'
    as all_dialog_loading_spinner_business;

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
      TextEditingController()..text = "testString";
  final FocusNode input1TextFieldFocus = FocusNode();
  String? input1TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input1TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  final TextEditingController input2TextFieldController =
      TextEditingController();
  final FocusNode input2TextFieldFocus = FocusNode();
  String? input2TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input2TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  final TextEditingController input3TextFieldController =
      TextEditingController()..text = "1";
  final FocusNode input3TextFieldFocus = FocusNode();
  String? input3TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input3TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  final TextEditingController input4TextFieldController =
      TextEditingController();
  final FocusNode input4TextFieldFocus = FocusNode();
  String? input4TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input4TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  final TextEditingController input5TextFieldController =
      TextEditingController()..text = "1.0";
  final FocusNode input5TextFieldFocus = FocusNode();
  String? input5TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input5TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  final TextEditingController input6TextFieldController =
      TextEditingController();
  final FocusNode input6TextFieldFocus = FocusNode();
  String? input6TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input6TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  bool input7Value = true;
  gc_template_classes.RefreshableBloc input7TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  bool? input8Value;
  gc_template_classes.RefreshableBloc input8TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  List<Input9ListItemViewModel> input9List = [Input9ListItemViewModel()];
  gc_template_classes.RefreshableBloc input9ListBloc =
      gc_template_classes.RefreshableBloc();

  List<Input10ListItemViewModel> input10List = [];
  gc_template_classes.RefreshableBloc input10ListBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (리스트 파라미터 추가)
  void addInput9ListItem() {
    input9List.add(Input9ListItemViewModel());
    input9ListBloc.refreshUi();
  }

  // (리스트 파라미터 제거)
  void deleteInput9ListItem(int idx) {
    var input9Item = input9List[idx];
    input9Item.inputTextFieldController.dispose();
    input9Item.inputTextFieldFocus.dispose();
    input9List.removeAt(idx);
    input9ListBloc.refreshUi();
  }

  // (리스트 파라미터 추가)
  void addInput10ListItem() {
    input10List.add(Input10ListItemViewModel());
    input10ListBloc.refreshUi();
  }

  // (리스트 파라미터 제거)
  void deleteInput10ListItem(int idx) {
    var input10Item = input10List[idx];
    input10Item.inputTextFieldController.dispose();
    input10Item.inputTextFieldFocus.dispose();
    input10List.removeAt(idx);
    input10ListBloc.refreshUi();
  }

  // (네트워크 리퀘스트)
  Future<void> doNetworkRequest() async {
    // 로딩 다이얼로그 표시
    all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () async {
              String input1Text = input1TextFieldController.text;
              if (input1Text.isEmpty) {
                // 로딩 다이얼로그 제거
                allDialogLoadingSpinnerBusiness.closeDialog();
                input1TextFieldErrorMsg = '이 항목을 입력 하세요.';
                input1TextFieldBloc.refreshUi();
                FocusScope.of(context).requestFocus(input1TextFieldFocus);
                return;
              }

              String input3Text = input3TextFieldController.text;
              if (input3Text.isEmpty) {
                allDialogLoadingSpinnerBusiness.closeDialog();
                input3TextFieldErrorMsg = '이 항목을 입력 하세요.';
                input3TextFieldBloc.refreshUi();
                FocusScope.of(context).requestFocus(input3TextFieldFocus);
                return;
              }

              String input5Text = input5TextFieldController.text;
              if (input5Text.isEmpty) {
                allDialogLoadingSpinnerBusiness.closeDialog();
                input5TextFieldErrorMsg = '이 항목을 입력 하세요.';
                input5TextFieldBloc.refreshUi();
                FocusScope.of(context).requestFocus(input5TextFieldFocus);
                return;
              }

              List<String> queryParamStringList = [];
              for (Input9ListItemViewModel tec in input9List) {
                String value = tec.inputTextFieldController.text;
                print(value);
                if (value.isEmpty) {
                  allDialogLoadingSpinnerBusiness.closeDialog();
                  tec.inputTextFieldErrorMsg = '이 항목을 입력 하세요.';
                  tec.inputTextFieldBloc.refreshUi();
                  FocusScope.of(context).requestFocus(tec.inputTextFieldFocus);
                  return;
                }
                queryParamStringList.add(value);
              }

              List<String>? queryParamStringListNullable;
              if (input10List.isNotEmpty) {
                queryParamStringListNullable = [];
                for (Input10ListItemViewModel tec in input10List) {
                  String value = tec.inputTextFieldController.text;
                  if (value.isEmpty) {
                    allDialogLoadingSpinnerBusiness.closeDialog();
                    tec.inputTextFieldErrorMsg = '이 항목을 입력 하세요.';
                    tec.inputTextFieldBloc.refreshUi();
                    FocusScope.of(context)
                        .requestFocus(tec.inputTextFieldFocus);
                    return;
                  }
                  queryParamStringListNullable.add(value);
                }
              }

              var response = await api_main_server
                  .getService1TkV1RequestTestGetRequestAsync(
                      requestQueryVo: api_main_server
                          .GetService1TkV1RequestTestGetRequestAsyncRequestQueryVo(
                              queryParamString: input1Text,
                              queryParamStringNullable:
                                  (input2TextFieldController.text == "")
                                      ? null
                                      : input2TextFieldController.text,
                              queryParamInt: int.parse(input3Text),
                              queryParamIntNullable: (input4TextFieldController
                                          .text ==
                                      "")
                                  ? null
                                  : int.parse(input4TextFieldController.text),
                              queryParamDouble: double.parse(input5Text),
                              queryParamDoubleNullable:
                                  (input6TextFieldController.text == "")
                                      ? null
                                      : double.parse(
                                          input6TextFieldController.text),
                              queryParamBoolean: input7Value,
                              queryParamBooleanNullable: input8Value,
                              queryParamStringList: queryParamStringList,
                              queryParamStringListNullable:
                                  queryParamStringListNullable));

              // 로딩 다이얼로그 제거
              allDialogLoadingSpinnerBusiness.closeDialog();

              if (response.dioException == null) {
                // Dio 네트워크 응답

                var networkResponseObjectOk = response.networkResponseObjectOk!;

                if (networkResponseObjectOk.responseStatusCode == 200) {
                  // 정상 응답

                  // 응답 body
                  var responseBody = networkResponseObjectOk.responseBody
                      as api_main_server
                      .GetService1TkV1RequestTestGetRequestAsyncResponseBodyVo;

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
            })).then((outputVo) {});
  }

// [private 함수]
}

class Input9ListItemViewModel {
  final TextEditingController inputTextFieldController = TextEditingController()
    ..text = "testString";
  final FocusNode inputTextFieldFocus = FocusNode();
  String? inputTextFieldErrorMsg;
  gc_template_classes.RefreshableBloc inputTextFieldBloc =
      gc_template_classes.RefreshableBloc();
}

class Input10ListItemViewModel {
  final TextEditingController inputTextFieldController = TextEditingController()
    ..text = "testString";
  final FocusNode inputTextFieldFocus = FocusNode();
  String? inputTextFieldErrorMsg;
  gc_template_classes.RefreshableBloc inputTextFieldBloc =
      gc_template_classes.RefreshableBloc();
}
