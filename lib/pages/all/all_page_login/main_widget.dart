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
const pageName = "all_page_login";

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
      pageTitle: "로그인",
      backgroundColor: Colors.blue,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 45,
              ),
              const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 100.0,
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 220.0,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: gw_sfw_wrapper.SfwRefreshWrapper(
                  key: mainBusiness.idTextFieldAreaGk,
                  widgetBuild: (context) {
                    mainBusiness.idTextFieldContext = context;

                    return TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.username],
                      controller: mainBusiness.idTextFieldController,
                      focusNode: mainBusiness.idTextFieldFocus,
                      decoration: InputDecoration(
                        labelText: "이메일 입력",
                        floatingLabelStyle: const TextStyle(color: Colors.blue),
                        hintText: 'user@email.com',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: mainBusiness.idTextFieldErrorMsg,
                        prefixIcon: const InkWell(
                          child: Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: 24.0, // 아이콘 크기 조정
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            mainBusiness.idTextFieldController.text = "";
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      onChanged: (value) {
                        // 입력값 변경시 에러 메세지 삭제
                        if (mainBusiness.idTextFieldErrorMsg != null) {
                          mainBusiness.idTextFieldErrorMsg = null;
                          mainBusiness.idTextFieldAreaGk.currentState
                              ?.refreshUi();
                        }
                      },
                      onEditingComplete: () {
                        mainBusiness.onIdFieldSubmitted();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: 220.0,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: gw_sfw_wrapper.SfwRefreshWrapper(
                  key: mainBusiness.passwordTextFieldAreaGk,
                  widgetBuild: (context) {
                    mainBusiness.passwordTextFieldContext = context;

                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: mainBusiness.passwordTextFieldController,
                      focusNode: mainBusiness.passwordTextFieldFocus,
                      obscureText: mainBusiness.passwordTextFieldHide,
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                        labelText: "비밀번호 입력",
                        floatingLabelStyle: const TextStyle(color: Colors.blue),
                        hintText: 'xxxxxxxxxxx',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
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
                                !mainBusiness.passwordTextFieldHide;
                            mainBusiness.passwordTextFieldAreaGk.currentState
                                ?.refreshUi();
                          },
                        ),
                        errorText: mainBusiness.passwordTextFieldErrorMsg,
                      ),
                      onChanged: (value) {
                        // 입력값 변경시 에러 메세지 삭제
                        if (mainBusiness.passwordTextFieldErrorMsg != null) {
                          mainBusiness.passwordTextFieldErrorMsg = null;
                          mainBusiness.passwordTextFieldAreaGk.currentState
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
              const SizedBox(height: 20.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    mainBusiness.goToFindPasswordPage();
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Text(
                          '비밀번호를 잊어버렸나요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
                        )),
                        Text(
                          '✓',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontFamily: "MaruBuri"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 40,
                constraints: const BoxConstraints(minWidth: 200),
                child: ElevatedButton(
                  onPressed: () {
                    mainBusiness.accountLoginAsync();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  child: const Text(
                    '계정 로그인',
                    style: TextStyle(fontFamily: "MaruBuri"),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                constraints: const BoxConstraints(maxWidth: 185),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(
                      '아직 회원이 아닌가요?',
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    mainBusiness.selectRegisterWith();
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 185),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '회원 가입하러 가기',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontFamily: "MaruBuri"),
                          textAlign: TextAlign.center,
                        )
                      ],
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
