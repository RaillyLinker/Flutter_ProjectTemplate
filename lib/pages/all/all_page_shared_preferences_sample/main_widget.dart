// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

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
const pageName = "all_page_shared_preferences_sample";

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
      pageTitle: "SharedPreferences 샘플",
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Text("키 : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "MaruBuri",
                              fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("\"${mainBusiness.spwKey}\"",
                          style: const TextStyle(
                              color: Colors.black, fontFamily: "MaruBuri")))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Row(
                  children: [
                    Text("값 : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "MaruBuri",
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text("    {\"sampleInt\" : ",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "MaruBuri"))),
                    gw_sfw_wrapper.SfwRefreshWrapper(
                      key: mainBusiness.sampleIntAreaGk,
                      widgetBuild: (context) {
                        mainBusiness.sampleIntContext = context;

                        return Expanded(
                            child: Text("${mainBusiness.sampleInt},",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri")));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text("    \"sampleString\" : ",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "MaruBuri"))),
                    gw_sfw_wrapper.SfwRefreshWrapper(
                      key: mainBusiness.sampleStringAreaGk,
                      widgetBuild: (context) {
                        mainBusiness.sampleStringContext = context;

                        return Expanded(
                            child: Text("${mainBusiness.sampleString}}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri")));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Row(
                  children: [
                    Text("입력값 : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "MaruBuri",
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: gw_sfw_wrapper.SfwRefreshWrapper(
                        key: mainBusiness.sampleIntTextFieldAreaGk,
                        widgetBuild: (context) {
                          mainBusiness.sampleIntTextFieldContext = context;

                          return TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller:
                                mainBusiness.sampleIntTextFieldController,
                            focusNode: mainBusiness.sampleIntTextFieldFocus,
                            decoration: InputDecoration(
                              labelText: "정수값 입력",
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              hintText: "정수값을 입력하세요.",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                              errorText:
                                  mainBusiness.sampleIntTextFieldErrorMsg,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  mainBusiness
                                      .sampleIntTextFieldController.text = "";
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (mainBusiness.sampleIntTextFieldErrorMsg !=
                                  null) {
                                mainBusiness.sampleIntTextFieldErrorMsg = null;
                                mainBusiness
                                    .sampleIntTextFieldAreaGk.currentState
                                    ?.refreshUi();
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: gw_sfw_wrapper.SfwRefreshWrapper(
                        key: mainBusiness.sampleStringTextFieldAreaGk,
                        widgetBuild: (context) {
                          mainBusiness.sampleStringTextFieldContext = context;

                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller:
                                mainBusiness.sampleStringTextFieldController,
                            focusNode: mainBusiness.sampleStringTextFieldFocus,
                            decoration: InputDecoration(
                              labelText: "문자열 입력",
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              hintText: "문자열을 입력하세요.",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                              errorText:
                                  mainBusiness.sampleStringTextFieldErrorMsg,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  mainBusiness.sampleStringTextFieldController
                                      .text = "";
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (mainBusiness.sampleStringTextFieldErrorMsg !=
                                  null) {
                                mainBusiness.sampleStringTextFieldErrorMsg =
                                    null;
                                mainBusiness
                                    .sampleStringTextFieldAreaGk.currentState
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
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      mainBusiness.spValueChangeBtnClick();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "SharedPreferences 값 변경",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      mainBusiness.spValueDeleteBtnClick();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "SharedPreferences 값 삭제",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
