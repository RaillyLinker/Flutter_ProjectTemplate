// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.
// todo : 로딩 처리 개선

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_image_loading_sample";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
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
class PageWidget extends StatefulWidget {
  const PageWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  PageWidgetState createState() => PageWidgetState();
}

class PageWidgetState extends State<PageWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = page_widget_business.PageWidgetBusiness();
    business.onCheckPageInputVo(goRouterState: widget.goRouterState);
    business.refreshUi = refreshUi;
    business.context = context;
    business.initState();
  }

  @override
  void dispose() {
    business.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    business.context = context;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained();
        },
        onFocusLost: () async {
          await business.onFocusLost();
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost();
        },
        onForegroundGained: () async {
          await business.onForegroundGained();
        },
        onForegroundLost: () async {
          await business.onForegroundLost();
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late page_widget_business.PageWidgetBusiness business;

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required page_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_page_outer_frame.SlWidget(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
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
      ),
    );
  }
}
