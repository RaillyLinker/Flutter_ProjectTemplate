// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

// (inner_folder)
import 'main_business.dart' as main_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

// [위젯 뷰]

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!! - 폴더명과 동일하게 작성하세요.
const pageName = "all_page_crypt_sample";

// !!!페이지 호출/반납 애니메이션!!! - 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    if (mainBusiness.pageInitFirst) {
      mainBusiness.pageInitFirst = false;
      mainBusiness.onCreate();
    }
    return PopScope(
      canPop: mainBusiness.canPop,
      child: FocusDetector(
        onFocusGained: () async {
          await mainBusiness.onFocusGainedAsync();
        },
        onFocusLost: () async {
          await mainBusiness.onFocusLostAsync();
        },
        onVisibilityGained: () async {
          await mainBusiness.onVisibilityGainedAsync();
        },
        onVisibilityLost: () async {
          await mainBusiness.onVisibilityLostAsync();
        },
        onForegroundGained: () async {
          await mainBusiness.onForegroundGainedAsync();
        },
        onForegroundLost: () async {
          await mainBusiness.onForegroundLostAsync();
        },
        child: getScreenWidget(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    final InputVo? inputVo =
        mainBusiness.onCheckPageInputVo(goRouterState: widget.goRouterState);
    if (inputVo == null) {
      mainBusiness.inputError = true;
    } else {
      mainBusiness.inputVo = inputVo;
    }
    mainBusiness.initState();
  }

  @override
  void dispose() {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    mainBusiness.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (mainBusiness) - 데이터 변수 및 함수 저장 역할
  final main_business.MainBusiness mainBusiness = main_business.MainBusiness();

  //----------------------------------------------------------------------------
  // !!!위젯 관련 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (MainWidget Refresh 함수)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!화면 위젯 작성 하기!!!

    if (mainBusiness.inputError == true) {
      // 입력값이 미충족 되었을 때의 화면
      return gw_slw_page_outer_frame.ErrorPageWidget(
        business: gw_slw_page_outer_frame.ErrorPageWidgetBusiness(),
        errorMsg: "잘못된 접근입니다.",
      );
    }

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: mainBusiness.pageOutFrameBusiness,
      pageTitle: "암/복호화 샘플",
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                                color: Colors.blue, width: 1.0), // 테두리 스타일 조정
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              child: Column(
                                children: [
                                  const Text('AES256 알고리즘',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "MaruBuri")),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                          flex: 20,
                                          child:
                                              gw_sfw_wrapper.SfwRefreshWrapper(
                                            key: mainBusiness
                                                .input1TextFieldAreaGk,
                                            widgetBuild: (context) {
                                              mainBusiness
                                                      .input1TextFieldAreaContext =
                                                  context;

                                              return TextFormField(
                                                autofocus: true,
                                                maxLength: 32,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-zA-Z0-9]')),
                                                ],
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: mainBusiness
                                                    .input1TextFieldController,
                                                focusNode: mainBusiness
                                                    .input1TextFieldFocus,
                                                decoration: InputDecoration(
                                                  errorText: mainBusiness
                                                      .input1TextFieldErrorMsg,
                                                  labelText: '암호키',
                                                  hintText: "암호화 키 32자 입력",
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // 입력값 변경시 에러 메세지 삭제
                                                  if (mainBusiness
                                                          .input1TextFieldErrorMsg !=
                                                      null) {
                                                    mainBusiness
                                                            .input1TextFieldErrorMsg =
                                                        null;
                                                    mainBusiness
                                                        .input1TextFieldAreaGk
                                                        .currentState
                                                        ?.refreshUi();
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  mainBusiness
                                                      .input1StateEntered();
                                                },
                                              );
                                            },
                                          )),
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                          flex: 20,
                                          child:
                                              gw_sfw_wrapper.SfwRefreshWrapper(
                                            key: mainBusiness
                                                .input2TextFieldAreaGk,
                                            widgetBuild: (context) {
                                              mainBusiness
                                                      .input2TextFieldAreaContext =
                                                  context;

                                              return TextFormField(
                                                maxLength: 16,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-zA-Z0-9]')),
                                                ],
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: mainBusiness
                                                    .input2TextFieldController,
                                                focusNode: mainBusiness
                                                    .input2TextFieldFocus,
                                                decoration: InputDecoration(
                                                  errorText: mainBusiness
                                                      .input2TextFieldErrorMsg,
                                                  labelText: '초기화 벡터',
                                                  hintText: "암호 초기화 벡터 16자 입력",
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // 입력값 변경시 에러 메세지 삭제
                                                  if (mainBusiness
                                                          .input2TextFieldErrorMsg !=
                                                      null) {
                                                    mainBusiness
                                                            .input2TextFieldErrorMsg =
                                                        null;
                                                    mainBusiness
                                                        .input2TextFieldAreaGk
                                                        .currentState
                                                        ?.refreshUi();
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  mainBusiness
                                                      .input2StateEntered();
                                                },
                                              );
                                            },
                                          )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                          flex: 20,
                                          child:
                                              gw_sfw_wrapper.SfwRefreshWrapper(
                                            key: mainBusiness
                                                .input3TextFieldAreaGk,
                                            widgetBuild: (context) {
                                              mainBusiness
                                                      .input3TextFieldAreaContext =
                                                  context;

                                              return TextFormField(
                                                maxLength: 16,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-zA-Z0-9]')),
                                                ],
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: mainBusiness
                                                    .input3TextFieldController,
                                                focusNode: mainBusiness
                                                    .input3TextFieldFocus,
                                                decoration: InputDecoration(
                                                  errorText: mainBusiness
                                                      .input3TextFieldErrorMsg,
                                                  labelText: '암호화할 평문',
                                                  hintText: "암호화할 평문을 입력하세요.",
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // 입력값 변경시 에러 메세지 삭제
                                                  if (mainBusiness
                                                          .input3TextFieldErrorMsg !=
                                                      null) {
                                                    mainBusiness
                                                            .input3TextFieldErrorMsg =
                                                        null;
                                                    mainBusiness
                                                        .input3TextFieldAreaGk
                                                        .currentState
                                                        ?.refreshUi();
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  mainBusiness
                                                      .input3StateEntered();
                                                },
                                              );
                                            },
                                          )),
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                          flex: 10,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              mainBusiness.doEncrypt();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "암호화",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MaruBuri"),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Expanded(
                                          flex: 20,
                                          child: Text(
                                            "결과 :",
                                            style: TextStyle(
                                                fontFamily: "MaruBuri"),
                                          )),
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                        flex: 80,
                                        child: gw_sfw_wrapper.SfwRefreshWrapper(
                                          key: mainBusiness
                                              .encryptResultTextAreaGk,
                                          widgetBuild: (context) {
                                            mainBusiness
                                                    .encryptResultTextAreaContext =
                                                context;

                                            return SelectableText(
                                              mainBusiness.encryptResultText,
                                              style: const TextStyle(
                                                  fontFamily: "MaruBuri"),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                          flex: 20,
                                          child:
                                              gw_sfw_wrapper.SfwRefreshWrapper(
                                            key: mainBusiness
                                                .input4TextFieldAreaGk,
                                            widgetBuild: (context) {
                                              mainBusiness
                                                      .input4TextFieldAreaContext =
                                                  context;

                                              return TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: mainBusiness
                                                    .input4TextFieldController,
                                                focusNode: mainBusiness
                                                    .input4TextFieldFocus,
                                                decoration: InputDecoration(
                                                  errorText: mainBusiness
                                                      .input4TextFieldErrorMsg,
                                                  labelText: '복호화할 암호문',
                                                  hintText: "복호화할 암호문을 입력하세요.",
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // 입력값 변경시 에러 메세지 삭제
                                                  if (mainBusiness
                                                          .input4TextFieldErrorMsg !=
                                                      null) {
                                                    mainBusiness
                                                            .input4TextFieldErrorMsg =
                                                        null;
                                                    mainBusiness
                                                        .input4TextFieldAreaGk
                                                        .currentState
                                                        ?.refreshUi();
                                                  }
                                                },
                                                onEditingComplete: () {
                                                  mainBusiness
                                                      .input4StateEntered();
                                                },
                                              );
                                            },
                                          )),
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                          flex: 10,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              mainBusiness.doDecrypt();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "복호화",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MaruBuri"),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Expanded(
                                          flex: 20,
                                          child: Text(
                                            "결과 :",
                                            style: TextStyle(
                                                fontFamily: "MaruBuri"),
                                          )),
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                        flex: 80,
                                        child: gw_sfw_wrapper.SfwRefreshWrapper(
                                          key: mainBusiness
                                              .decryptResultTextAreaGk,
                                          widgetBuild: (context) {
                                            mainBusiness
                                                    .decryptResultTextAreaContext =
                                                context;

                                            return SelectableText(
                                              mainBusiness.decryptResultText,
                                              style: const TextStyle(
                                                  fontFamily: "MaruBuri"),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
