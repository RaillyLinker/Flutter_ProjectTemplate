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
const pageName = "all_page_find_password_with_email";

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
      pageTitle: "비밀번호 찾기",
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
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 중복 확인 버튼 동작
                                    mainBusiness.sendVerificationEmail();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2),
                                      child: const Text(
                                        "이메일\n발송",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: gw_sfw_wrapper.SfwRefreshWrapper(
                                key: mainBusiness
                                    .verificationCodeTextFieldAreaGk,
                                widgetBuild: (context) {
                                  mainBusiness
                                          .verificationCodeTextFieldContext =
                                      context;

                                  return TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: mainBusiness
                                        .verificationCodeTextFieldController,
                                    focusNode: mainBusiness
                                        .verificationCodeTextFieldFocus,
                                    decoration: InputDecoration(
                                      labelText: '본인 인증 코드',
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.blue),
                                      hintText: "이메일로 발송된 본인 인증 코드",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: mainBusiness
                                          .verificationCodeTextFieldErrorMsg,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          mainBusiness
                                              .verificationCodeTextFieldController
                                              .text = "";
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // 입력값 변경시 에러 메세지 삭제
                                      if (mainBusiness
                                              .verificationCodeTextFieldErrorMsg !=
                                          null) {
                                        mainBusiness
                                                .verificationCodeTextFieldErrorMsg =
                                            null;
                                        mainBusiness
                                            .verificationCodeTextFieldAreaGk
                                            .currentState
                                            ?.refreshUi();
                                      }
                                    },
                                    onEditingComplete: () {
                                      mainBusiness
                                          .onVerificationCodeFieldSubmitted();
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    mainBusiness.findPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '비밀번호 찾기',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 300,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    '이메일 주소를 입력 후 이메일 발송 버튼을 누르세요.\n\n'
                    '입력한 이메일 주소로 전송된 본인 인증 코드를 10분 안에 입력하세요.\n\n'
                    '이메일을 받지 못했다면,\n'
                    '- 입력한 이메일 주소가 올바른지 확인하세요.\n'
                    '- 이메일 스팸 보관함을 확인하세요.\n'
                    '- 이메일 저장소 용량이 충분한지 확인하세요.',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontFamily: "MaruBuri"),
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
