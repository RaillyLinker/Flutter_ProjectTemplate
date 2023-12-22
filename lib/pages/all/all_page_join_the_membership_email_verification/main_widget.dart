// (external)
import 'package:flutter/material.dart';
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
const pageName = "all_page_register_email_verification";

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
      pageTitle: "회원가입 : 본인 이메일 검증 (1/2)",
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 20,
                              child: gw_sfw_wrapper.SfwRefreshWrapper(
                                key: mainBusiness.emailTextFieldAreaGk,
                                widgetBuild: (context) {
                                  mainBusiness.emailTextFieldContext = context;

                                  return TextFormField(
                                    enabled: mainBusiness.emailTextEditEnabled,
                                    autofocus: true,
                                    keyboardType: TextInputType.text,
                                    controller:
                                        mainBusiness.emailTextFieldController,
                                    focusNode: mainBusiness.emailTextFieldFocus,
                                    decoration: InputDecoration(
                                      labelText: '이메일',
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.blue),
                                      hintText: "user@email.com",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText:
                                          mainBusiness.emailTextFieldErrorMsg,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          mainBusiness.emailTextFieldController
                                              .text = "";
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // 입력값 변경시 에러 메세지 삭제
                                      if (mainBusiness.emailTextFieldErrorMsg !=
                                          null) {
                                        mainBusiness.emailTextFieldErrorMsg =
                                            null;
                                        mainBusiness
                                            .emailTextFieldAreaGk.currentState
                                            ?.refreshUi();
                                      }
                                    },
                                    onEditingComplete: () {
                                      mainBusiness.emailTextEditOnSubmitted();
                                    },
                                  );
                                },
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Expanded(
                              flex: 10,
                              child: gw_sfw_wrapper.SfwRefreshWrapper(
                                key: mainBusiness.emailCheckBtnAreaGk,
                                widgetBuild: (context) {
                                  mainBusiness.emailCheckBtnContext = context;

                                  return ElevatedButton(
                                    onPressed: () {
                                      // 중복 확인 버튼 동작
                                      mainBusiness.onEmailBtnClick();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 2, bottom: 2),
                                        child: Text(
                                          mainBusiness.emailCheckBtn,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "MaruBuri"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: gw_sfw_wrapper.SfwRefreshWrapper(
                                key: mainBusiness.passwordTextFieldAreaGk,
                                widgetBuild: (context) {
                                  mainBusiness.passwordTextFieldContext =
                                      context;

                                  return TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: mainBusiness
                                        .passwordTextFieldController,
                                    focusNode:
                                        mainBusiness.passwordTextFieldFocus,
                                    obscureText:
                                        mainBusiness.passwordTextFieldHide,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    decoration: InputDecoration(
                                      labelText: "비밀번호",
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.blue),
                                      hintText: 'xxxxxxxxxxx',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.key,
                                        color: Colors.grey,
                                        size: 24.0, // 아이콘 크기 조정
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          mainBusiness.passwordTextFieldHide
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          mainBusiness.passwordTextFieldHide =
                                              !mainBusiness
                                                  .passwordTextFieldHide;
                                          mainBusiness.passwordTextFieldAreaGk
                                              .currentState
                                              ?.refreshUi();
                                        },
                                      ),
                                      errorText: mainBusiness
                                          .passwordTextFieldErrorMsg,
                                    ),
                                    onChanged: (value) {
                                      // 입력값 변경시 에러 메세지 삭제
                                      if (mainBusiness
                                              .passwordTextFieldErrorMsg !=
                                          null) {
                                        mainBusiness.passwordTextFieldErrorMsg =
                                            null;
                                        mainBusiness.passwordTextFieldAreaGk
                                            .currentState
                                            ?.refreshUi();
                                      }
                                    },
                                    onEditingComplete: () {
                                      mainBusiness.onPasswordFieldSubmitted();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              mainBusiness.onPasswordInputRuleTap();
                            },
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.passwordInputRuleHideAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.passwordInputRuleHideContext =
                                    context;

                                var passwordInputRule = mainBusiness
                                        .passwordInputRuleHide
                                    ? const SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "비밀번호 입력 규칙",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontFamily: "MaruBuri"),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "비밀번호 입력 규칙",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontFamily: "MaruBuri"),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '1. 비밀번호의 길이는 최소 8자 이상으로 입력하세요.\n'
                                              '2. 비밀번호에 공백은 허용되지 않습니다.\n'
                                              '3. 비밀번호는 영문 대/소문자, 숫자, 특수문자의 조합으로 입력하세요.\n'
                                              '4. 아래 특수문자는 사용할 수 없습니다.\n'
                                              '    <, >, (, ), #, ’, /, |',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey,
                                                  fontFamily: "MaruBuri"),
                                            )
                                          ],
                                        ),
                                      );

                                return Container(
                                  width: 300,
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 10),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          // POINT
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        right: BorderSide(
                                          // POINT
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        bottom: BorderSide(
                                          // POINT
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        top: BorderSide(
                                          // POINT
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: passwordInputRule,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: gw_sfw_wrapper.SfwRefreshWrapper(
                                key: mainBusiness.passwordCheckTextFieldAreaGk,
                                widgetBuild: (context) {
                                  mainBusiness.passwordCheckTextFieldContext =
                                      context;

                                  return TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: mainBusiness
                                        .passwordCheckTextFieldController,
                                    focusNode: mainBusiness
                                        .passwordCheckTextFieldFocus,
                                    obscureText:
                                        mainBusiness.passwordCheckTextFieldHide,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    decoration: InputDecoration(
                                      labelText: "비밀번호 확인",
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.blue),
                                      hintText: 'xxxxxxxxxxx',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.key,
                                        color: Colors.grey,
                                        size: 24.0, // 아이콘 크기 조정
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          mainBusiness
                                                  .passwordCheckTextFieldHide
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          mainBusiness
                                                  .passwordCheckTextFieldHide =
                                              !mainBusiness
                                                  .passwordCheckTextFieldHide;
                                          mainBusiness
                                              .passwordCheckTextFieldAreaGk
                                              .currentState
                                              ?.refreshUi();
                                        },
                                      ),
                                      errorText: mainBusiness
                                          .passwordCheckTextFieldErrorMsg,
                                    ),
                                    onChanged: (value) {
                                      // 입력값 변경시 에러 메세지 삭제
                                      if (mainBusiness
                                              .passwordCheckTextFieldErrorMsg !=
                                          null) {
                                        mainBusiness
                                                .passwordCheckTextFieldErrorMsg =
                                            null;
                                        mainBusiness
                                            .passwordCheckTextFieldAreaGk
                                            .currentState
                                            ?.refreshUi();
                                      }
                                    },
                                    onEditingComplete: () {
                                      mainBusiness.goToNextStep();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    mainBusiness.goToNextStep();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '다음 (2/2)',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
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
