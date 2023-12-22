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
const pageName = "all_page_url_launcher_sample";

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
      pageTitle: "Url Launcher 샘플",
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Row(
                    children: [
                      Text("입력 : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "MaruBuri",
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 300,
                    height: 45,
                    child: gw_sfw_wrapper.SfwRefreshWrapper(
                      key: mainBusiness.urlTextFieldAreaGk,
                      widgetBuild: (context) {
                        mainBusiness.urlTextFieldContext = context;

                        return TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          controller: mainBusiness.urlTextFieldController,
                          focusNode: mainBusiness.urlTextFieldFocus,
                          decoration: InputDecoration(
                            labelText: 'Url',
                            floatingLabelStyle:
                                const TextStyle(color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            filled: true,
                            fillColor: Colors.grey[100],
                            errorText: mainBusiness.urlTextFieldErrorMsg,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                mainBusiness.urlTextFieldController.text = "";
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          onChanged: (value) {
                            // 입력값 변경시 에러 메세지 삭제
                            if (mainBusiness.urlTextFieldErrorMsg != null) {
                              mainBusiness.urlTextFieldErrorMsg = null;
                              mainBusiness.urlTextFieldAreaGk.currentState
                                  ?.refreshUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              mainBusiness.launchUrlInAppAsync();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text("앱 자체에서 열기",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "MaruBuri"))))),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        mainBusiness.launchUrlInBrowserAsync();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        "브라우저 앱에서 열기",
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
      ),
    );
  }
}
