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
const pageName = "all_page_post_request_sample3";

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
      pageTitle: "Post 메소드 요청 샘플 3 (multipart/form-data)",
      child: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "변수명",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "MaruBuri"),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "설명 및 입력",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "MaruBuri"),
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormString",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("String",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "String Form 파라미터",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input1TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input1TextFieldContext = context;

                                return TextFormField(
                                  autofocus: true,
                                  controller:
                                      mainBusiness.input1TextFieldController,
                                  focusNode: mainBusiness.input1TextFieldFocus,
                                  decoration: InputDecoration(
                                    errorText:
                                        mainBusiness.input1TextFieldErrorMsg,
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.blue),
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        mainBusiness.input1TextFieldController
                                            .text = "";
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // 입력값 변경시 에러 메세지 삭제
                                    if (mainBusiness.input1TextFieldErrorMsg !=
                                        null) {
                                      mainBusiness.input1TextFieldErrorMsg =
                                          null;
                                      mainBusiness
                                          .input1TextFieldAreaGk.currentState
                                          ?.refreshUi();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormStringNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("String?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "String Form 파라미터 Nullable",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input2TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input2TextFieldContext = context;

                                return TextFormField(
                                  controller:
                                      mainBusiness.input2TextFieldController,
                                  focusNode: mainBusiness.input2TextFieldFocus,
                                  decoration: InputDecoration(
                                    errorText:
                                        mainBusiness.input2TextFieldErrorMsg,
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.blue),
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        mainBusiness.input2TextFieldController
                                            .text = "";
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // 입력값 변경시 에러 메세지 삭제
                                    if (mainBusiness.input2TextFieldErrorMsg !=
                                        null) {
                                      mainBusiness.input2TextFieldErrorMsg =
                                          null;
                                      mainBusiness
                                          .input2TextFieldAreaGk.currentState
                                          ?.refreshUi();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormInt",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("Int",
                                        style: TextStyle(color: Colors.red))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Int Form 파라미터",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input3TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input3TextFieldContext = context;

                                return TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false, signed: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^-?[0-9]*$'),
                                    ),
                                  ],
                                  controller:
                                      mainBusiness.input3TextFieldController,
                                  focusNode: mainBusiness.input3TextFieldFocus,
                                  decoration: InputDecoration(
                                    errorText:
                                        mainBusiness.input3TextFieldErrorMsg,
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.blue),
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        mainBusiness.input3TextFieldController
                                            .text = "";
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // 입력값 변경시 에러 메세지 삭제
                                    if (mainBusiness.input3TextFieldErrorMsg !=
                                        null) {
                                      mainBusiness.input3TextFieldErrorMsg =
                                          null;
                                      mainBusiness
                                          .input3TextFieldAreaGk.currentState
                                          ?.refreshUi();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormIntNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("Int?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Int Form 파라미터 Nullable",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input4TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input4TextFieldContext = context;

                                return TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false, signed: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^-?[0-9]*$'),
                                    ),
                                  ],
                                  controller:
                                      mainBusiness.input4TextFieldController,
                                  focusNode: mainBusiness.input4TextFieldFocus,
                                  decoration: InputDecoration(
                                    errorText:
                                        mainBusiness.input4TextFieldErrorMsg,
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.blue),
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        mainBusiness.input4TextFieldController
                                            .text = "";
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // 입력값 변경시 에러 메세지 삭제
                                    if (mainBusiness.input4TextFieldErrorMsg !=
                                        null) {
                                      mainBusiness.input4TextFieldErrorMsg =
                                          null;
                                      mainBusiness
                                          .input4TextFieldAreaGk.currentState
                                          ?.refreshUi();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormDouble",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("Double",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Double Form 파라미터",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input5TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input5TextFieldContext = context;

                                return TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true, signed: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^-?[0-9]*\.?[0-9]*$'),
                                    ),
                                  ],
                                  controller:
                                      mainBusiness.input5TextFieldController,
                                  focusNode: mainBusiness.input5TextFieldFocus,
                                  decoration: InputDecoration(
                                    errorText:
                                        mainBusiness.input5TextFieldErrorMsg,
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.blue),
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        mainBusiness.input5TextFieldController
                                            .text = "";
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // 입력값 변경시 에러 메세지 삭제
                                    if (mainBusiness.input5TextFieldErrorMsg !=
                                        null) {
                                      mainBusiness.input5TextFieldErrorMsg =
                                          null;
                                      mainBusiness
                                          .input5TextFieldAreaGk.currentState
                                          ?.refreshUi();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormDoubleNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("Double?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Double Form 파라미터 Nullable",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input6TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input6TextFieldContext = context;

                                return TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true, signed: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^-?[0-9]*\.?[0-9]*$'),
                                    ),
                                  ],
                                  controller:
                                      mainBusiness.input6TextFieldController,
                                  focusNode: mainBusiness.input6TextFieldFocus,
                                  decoration: InputDecoration(
                                    errorText:
                                        mainBusiness.input6TextFieldErrorMsg,
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.blue),
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        mainBusiness.input6TextFieldController
                                            .text = "";
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // 입력값 변경시 에러 메세지 삭제
                                    if (mainBusiness.input6TextFieldErrorMsg !=
                                        null) {
                                      mainBusiness.input6TextFieldErrorMsg =
                                          null;
                                      mainBusiness
                                          .input6TextFieldAreaGk.currentState
                                          ?.refreshUi();
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormBoolean",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("Boolean",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Boolean Form 파라미터",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input7TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input7TextFieldContext = context;

                                return DropdownButton<bool>(
                                  value: mainBusiness.input7Value,
                                  items: <bool>[
                                    true,
                                    false
                                  ].map<DropdownMenuItem<bool>>((bool value) {
                                    return DropdownMenuItem<bool>(
                                      value: value,
                                      child: Text(
                                        "$value",
                                        style: const TextStyle(
                                            fontFamily: "MaruBuri"),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (bool? newValue) {
                                    mainBusiness.input7Value = newValue!;
                                    mainBusiness
                                        .input7TextFieldAreaGk.currentState
                                        ?.refreshUi();
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormBooleanNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("Boolean?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Boolean Form 파라미터 Nullable",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.input8TextFieldAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.input8TextFieldContext = context;

                                return DropdownButton<bool?>(
                                  value: mainBusiness.input8Value,
                                  items: <bool?>[
                                    true,
                                    false,
                                    null
                                  ].map<DropdownMenuItem<bool?>>((bool? value) {
                                    return DropdownMenuItem<bool?>(
                                      value: value,
                                      child: Text(
                                        "$value",
                                        style: const TextStyle(
                                            fontFamily: "MaruBuri"),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (bool? newValue) {
                                    mainBusiness.input8Value = newValue;
                                    mainBusiness
                                        .input8TextFieldAreaGk.currentState
                                        ?.refreshUi();
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormStringList",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("array[string]",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "StringList Form 파라미터",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gw_sfw_wrapper.SfwRefreshWrapper(
                                  key: mainBusiness.input9TextFieldListAreaGk,
                                  widgetBuild: (context) {
                                    mainBusiness.input9TextFieldListContext =
                                        context;
                                    List<Widget> widgetList = [];
                                    for (int idx = 0;
                                        idx < mainBusiness.input9List.length;
                                        idx++) {
                                      var tec = mainBusiness.input9List[idx];

                                      List<Widget> textFieldRow = [
                                        Expanded(
                                          child:
                                              gw_sfw_wrapper.SfwRefreshWrapper(
                                            key: tec.inputTextFieldAreaGk,
                                            widgetBuild: (context) {
                                              tec.inputTextFieldContext =
                                                  context;

                                              return TextFormField(
                                                controller: tec
                                                    .inputTextFieldController,
                                                focusNode:
                                                    tec.inputTextFieldFocus,
                                                decoration: InputDecoration(
                                                  errorText: tec
                                                      .inputTextFieldErrorMsg,
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      tec.inputTextFieldController
                                                          .text = "";
                                                    },
                                                    icon:
                                                        const Icon(Icons.clear),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // 입력값 변경시 에러 메세지 삭제
                                                  if (tec.inputTextFieldErrorMsg !=
                                                      null) {
                                                    tec.inputTextFieldErrorMsg =
                                                        null;
                                                    tec.inputTextFieldAreaGk
                                                        .currentState
                                                        ?.refreshUi();
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ];

                                      if (mainBusiness.input9List.length > 1) {
                                        textFieldRow.add(Container(
                                          margin:
                                              const EdgeInsets.only(left: 5),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                mainBusiness
                                                    .deleteInput9ListItem(idx);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text(
                                                "-",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MaruBuri"),
                                              )),
                                        ));
                                      }

                                      widgetList.add(Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: textFieldRow,
                                        ),
                                      ));
                                    }

                                    Column stringListColumn = Column(
                                      children: widgetList,
                                    );

                                    return stringListColumn;
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        mainBusiness.addInput9ListItem();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        "리스트 추가",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestFormStringListNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("array[string]?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(
                                  ")",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "StringList Form 파라미터 Nullable",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gw_sfw_wrapper.SfwRefreshWrapper(
                                  key: mainBusiness.input10TextFieldListAreaGk,
                                  widgetBuild: (context) {
                                    mainBusiness.input10TextFieldListContext =
                                        context;
                                    List<Widget> widgetList = [];
                                    for (int idx = 0;
                                        idx < mainBusiness.input10List.length;
                                        idx++) {
                                      var tec = mainBusiness.input10List[idx];

                                      List<Widget> textFieldRow = [
                                        Expanded(
                                          child:
                                              gw_sfw_wrapper.SfwRefreshWrapper(
                                            key: tec.inputTextFieldAreaGk,
                                            widgetBuild: (context) {
                                              tec.inputTextFieldContext =
                                                  context;

                                              return TextFormField(
                                                controller: tec
                                                    .inputTextFieldController,
                                                focusNode:
                                                    tec.inputTextFieldFocus,
                                                decoration: InputDecoration(
                                                  errorText: tec
                                                      .inputTextFieldErrorMsg,
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                          color: Colors.blue),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 10.0),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      tec.inputTextFieldController
                                                          .text = "";
                                                    },
                                                    icon:
                                                        const Icon(Icons.clear),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // 입력값 변경시 에러 메세지 삭제
                                                  if (tec.inputTextFieldErrorMsg !=
                                                      null) {
                                                    tec.inputTextFieldErrorMsg =
                                                        null;
                                                    tec.inputTextFieldAreaGk
                                                        .currentState
                                                        ?.refreshUi();
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ];

                                      textFieldRow.add(Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              mainBusiness
                                                  .deleteInput10ListItem(idx);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "MaruBuri"),
                                            )),
                                      ));

                                      widgetList.add(Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: textFieldRow,
                                        ),
                                      ));
                                    }

                                    Column stringListColumn = Column(
                                      children: widgetList,
                                    );

                                    return stringListColumn;
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        mainBusiness.addInput10ListItem();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        "리스트 추가",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "multipartFile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("MultipartFile",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Multipart File",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                gw_sfw_wrapper.SfwRefreshWrapper(
                                  key: mainBusiness.pickFile1AreaGk,
                                  widgetBuild: (context) {
                                    mainBusiness.pickFile1AreaContext = context;

                                    if (mainBusiness.pickedFile1 == null) {
                                      return const Text("Null",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "MaruBuri"));
                                    } else {
                                      return Text(
                                          mainBusiness.pickedFile1!.name,
                                          style: const TextStyle(
                                              fontFamily: "MaruBuri"));
                                    }
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        mainBusiness.pickFile1();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        "파일 선택",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "multipartFileNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 260),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("MultipartFile?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Multipart File Nullable",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.pickFile2AreaGk,
                              widgetBuild: (context) {
                                mainBusiness.pickFile2AreaContext = context;

                                Widget fileNameWidget = mainBusiness
                                            .pickedFile2 ==
                                        null
                                    ? const Text("Null",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))
                                    : Text(mainBusiness.pickedFile2!.name,
                                        style: const TextStyle(
                                            fontFamily: "MaruBuri"));

                                Widget filePickWidget =
                                    mainBusiness.pickedFile2 == null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              mainBusiness.pickFile2();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              "파일 선택",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "MaruBuri"),
                                            ))
                                        : ElevatedButton(
                                            onPressed: () {
                                              mainBusiness.deleteFile2();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              "파일 선택 취소",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "MaruBuri"),
                                            ));

                                return Column(
                                  children: [
                                    fileNameWidget,
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: filePickWidget,
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                    onPressed: () {
                      mainBusiness.doNetworkRequest();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "네트워크 요청 테스트",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
