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
const pageName = "app_page_server_sample";

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
      pageTitle: "서버 샘플",
      child: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Row(
                    children: [
                      const Text(
                        '접속 IP 주소:',
                        style: TextStyle(fontFamily: "MaruBuri"),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: gw_sfw_wrapper.SfwRefreshWrapper(
                          key: mainBusiness.portTextFieldAreaGk,
                          widgetBuild: (context) {
                            mainBusiness.portTextFieldContext = context;

                            return TextFormField(
                              enabled: mainBusiness.serverBtn == "서버 열기",
                              controller: mainBusiness.portTextFieldController,
                              maxLength: 4,
                              focusNode: mainBusiness.portTextFieldFocus,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                  hintText: '기본 포트 번호 9090',
                                  labelText: '포트 번호 입력',
                                  floatingLabelStyle:
                                      const TextStyle(color: Colors.blue),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  errorText:
                                      mainBusiness.portTextFieldErrorMsg),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      gw_sfw_wrapper.SfwRefreshWrapper(
                        key: mainBusiness.serverBtnAreaGk,
                        widgetBuild: (context) {
                          mainBusiness.serverBtnAreaContext = context;

                          return Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              if (mainBusiness.serverBtn == "서버 열기") {
                                mainBusiness.onClickOpenServerBtnAsync();
                              } else if (mainBusiness.serverBtn == "서버 닫기") {
                                mainBusiness.onClickCloseServerBtnAsync();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                              mainBusiness.serverBtn,
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: "MaruBuri"),
                            ),
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: gw_sfw_wrapper.SfwRefreshWrapper(
                    key: mainBusiness.logListAreaGk,
                    widgetBuild: (context) {
                      mainBusiness.logListAreaContext = context;

                      return ListView.builder(
                        itemCount: mainBusiness.logList.length,
                        itemBuilder: (context, index) {
                          String log = mainBusiness.logList[index];
                          return ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            title: Text(
                              log,
                              style: const TextStyle(fontFamily: "MaruBuri"),
                            ),
                          );
                        },
                      );
                    },
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
