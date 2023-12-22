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
const pageName = "all_page_form_sample";

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
      pageTitle: "폼 입력 샘플",
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 450,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black),
                bottom: BorderSide(width: 1.0, color: Colors.black),
                left: BorderSide(width: 1.0, color: Colors.black),
                right: BorderSide(width: 1.0, color: Colors.black),
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('테스트 폼',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MaruBuri")),
                  const SizedBox(height: 30.0),
                  gw_sfw_wrapper.SfwRefreshWrapper(
                    key: mainBusiness.input1TextFieldAreaGk,
                    widgetBuild: (context) {
                      mainBusiness.input1TextFieldContext = context;

                      return TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        controller: mainBusiness.input1TextFieldController,
                        focusNode: mainBusiness.input1TextFieldFocus,
                        decoration: InputDecoration(
                          labelText: '무제한 입력',
                          floatingLabelStyle:
                              const TextStyle(color: Colors.blue),
                          hintText: "아무 값이나 입력 하세요.",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          errorText: mainBusiness.input1TextFieldErrorMsg,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              mainBusiness.input1TextFieldController.text = "";
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        onChanged: (value) {
                          // 입력값 변경시 에러 메세지 삭제
                          if (mainBusiness.input1TextFieldErrorMsg != null) {
                            mainBusiness.input1TextFieldErrorMsg = null;
                            mainBusiness.input1TextFieldAreaGk.currentState
                                ?.refreshUi();
                          }
                        },
                        onEditingComplete: () {
                          mainBusiness.input1StateEntered();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  gw_sfw_wrapper.SfwRefreshWrapper(
                    key: mainBusiness.input2TextFieldAreaGk,
                    widgetBuild: (context) {
                      mainBusiness.input2TextFieldContext = context;

                      return TextFormField(
                        keyboardType: TextInputType.text,
                        controller: mainBusiness.input2TextFieldController,
                        focusNode: mainBusiness.input2TextFieldFocus,
                        maxLength: 16,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]')),
                        ],
                        decoration: InputDecoration(
                          labelText: '영문 / 숫자 16자 입력',
                          floatingLabelStyle:
                              const TextStyle(color: Colors.blue),
                          hintText: "영문 / 숫자를 16자 입력 하세요.",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              mainBusiness.input2TextFieldController.text = "";
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          errorText: mainBusiness.input2TextFieldErrorMsg,
                        ),
                        onChanged: (value) {
                          // 입력값 변경시 에러 메세지 삭제
                          if (mainBusiness.input2TextFieldErrorMsg != null) {
                            mainBusiness.input2TextFieldErrorMsg = null;
                            mainBusiness.input2TextFieldAreaGk.currentState
                                ?.refreshUi();
                          }
                        },
                        onEditingComplete: () {
                          mainBusiness.input2StateEntered();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  gw_sfw_wrapper.SfwRefreshWrapper(
                    key: mainBusiness.input3TextFieldAreaGk,
                    widgetBuild: (context) {
                      mainBusiness.input3TextFieldContext = context;

                      return TextFormField(
                        keyboardType: TextInputType.number,
                        controller: mainBusiness.input3TextFieldController,
                        focusNode: mainBusiness.input3TextFieldFocus,
                        maxLength: 16,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          labelText: '숫자 16자 이내 입력',
                          floatingLabelStyle:
                              const TextStyle(color: Colors.blue),
                          hintText: "숫자를 16자 이내에 입력 하세요.",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              mainBusiness.input3TextFieldController.text = "";
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          errorText: mainBusiness.input3TextFieldErrorMsg,
                        ),
                        onChanged: (value) {
                          // 입력값 변경시 에러 메세지 삭제
                          if (mainBusiness.input3TextFieldErrorMsg != null) {
                            mainBusiness.input3TextFieldErrorMsg = null;
                            mainBusiness.input3TextFieldAreaGk.currentState
                                ?.refreshUi();
                          }
                        },
                        onEditingComplete: () {
                          mainBusiness.input3StateEntered();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  gw_sfw_wrapper.SfwRefreshWrapper(
                    key: mainBusiness.input4TextFieldAreaGk,
                    widgetBuild: (context) {
                      mainBusiness.input4TextFieldContext = context;

                      return TextFormField(
                        keyboardType: TextInputType.text,
                        controller: mainBusiness.input4TextFieldController,
                        focusNode: mainBusiness.input4TextFieldFocus,
                        maxLength: 16,
                        obscureText: mainBusiness.input4TextFieldHide,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          labelText: "암호값 입력",
                          floatingLabelStyle:
                              const TextStyle(color: Colors.blue),
                          hintText: '암호값을 입력하면 숨김 처리가 됩니다.',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.grey,
                            size: 24.0, // 아이콘 크기 조정
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              mainBusiness.input4TextFieldHide
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              mainBusiness.input4TextFieldHide =
                                  !mainBusiness.input4TextFieldHide;
                              mainBusiness.input4TextFieldAreaGk.currentState
                                  ?.refreshUi();
                            },
                          ),
                          errorText: mainBusiness.input4TextFieldErrorMsg,
                        ),
                        onChanged: (value) {
                          // 입력값 변경시 에러 메세지 삭제
                          if (mainBusiness.input4TextFieldErrorMsg != null) {
                            mainBusiness.input4TextFieldErrorMsg = null;
                            mainBusiness.input4TextFieldAreaGk.currentState
                                ?.refreshUi();
                          }
                        },
                        onEditingComplete: () {
                          mainBusiness.input4StateEntered();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () {
                      mainBusiness.completeTestForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "폼 완료",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "MaruBuri",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
