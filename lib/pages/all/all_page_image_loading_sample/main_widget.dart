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
// todo 이미지 로딩 개선

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!! - 폴더명과 동일하게 작성하세요.
const pageName = "all_page_image_loading_sample";

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
      pageTitle: "이미지 로딩 샘플",
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black),
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                          left: BorderSide(width: 1.0, color: Colors.black),
                          right: BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                      child: Image(
                        // 바로 이미지를 내려주는 샘플
                        image: const NetworkImage(
                            "http://127.0.0.1:8080/service1/tk/v1/file-test/client-image-test?delayTimeSecond=0"),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                          if (loadingProgress == null) {
                            return child; // 로딩이 끝났을 경우
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: Text(
                        "바로 로딩",
                        style: TextStyle(fontFamily: "MaruBuri"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black),
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                          left: BorderSide(width: 1.0, color: Colors.black),
                          right: BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                      child: Image(
                        // 5초 후 이미지를 내려주는 샘플
                        image: const NetworkImage(
                            "http://127.0.0.1:8080/service1/tk/v1/file-test/client-image-test?delayTimeSecond=5"),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                          if (loadingProgress == null) {
                            return child; // 로딩이 끝났을 경우
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: Text(
                        "5초 후 로딩",
                        style: TextStyle(fontFamily: "MaruBuri"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black),
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                          left: BorderSide(width: 1.0, color: Colors.black),
                          right: BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                      child: Image(
                        // 이미지를 내려주지 않고 에러가 나는 샘플
                        image: const NetworkImage(
                            "http://127.0.0.1:8080/service1/tk/v1/file-test/client-image-test?delayTimeSecond=-1"),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                          if (loadingProgress == null) {
                            return child; // 로딩이 끝났을 경우
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: Text(
                        "에러 발생",
                        style: TextStyle(fontFamily: "MaruBuri"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
