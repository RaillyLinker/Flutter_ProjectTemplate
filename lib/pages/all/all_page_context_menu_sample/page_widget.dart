// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;
import '../../../global_widgets/gw_context_menu_region/sf_widget.dart'
    as gw_context_menu_region_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_context_menu_sample";

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
        pageTitle: "컨텍스트 메뉴 샘플",
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                gw_context_menu_region_view.SfWidget(
                  globalKey: business.contextMenuRegionGk,
                  inputVo: gw_context_menu_region_view.InputVo(
                      contextMenuRegionItemVoList: [
                        gw_context_menu_region_view.ContextMenuRegionItemVo(
                            menuItemWidget: const Text(
                              "토스트 테스트",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "MaruBuri"),
                            ),
                            menuItemCallback: () {
                              business.toastTestMenuBtn();
                            }),
                        gw_context_menu_region_view.ContextMenuRegionItemVo(
                            menuItemWidget: const Text(
                              "다이얼로그 테스트",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "MaruBuri"),
                            ),
                            menuItemCallback: () {
                              business.dialogTestMenuBtn();
                            }),
                      ],
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        color: Colors.blue[100], // 옅은 파란색
                        child: const Text(
                          '우클릭 해보세요.',
                          style: TextStyle(
                              color: Colors.black, fontFamily: "MaruBuri"),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 100,
                ),
                gw_context_menu_region_view.SfWidget(
                  globalKey: business.contextMenuRegionGk2,
                  inputVo: gw_context_menu_region_view.InputVo(
                      contextMenuRegionItemVoList: [
                        gw_context_menu_region_view.ContextMenuRegionItemVo(
                            menuItemWidget: const Text(
                              "뒤로가기",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "MaruBuri"),
                            ),
                            menuItemCallback: () {
                              business.goBackBtn();
                            }),
                      ],
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        color: Colors.blue[100], // 옅은 파란색
                        child: const Text(
                          '모바일에선 길게 누르세요.',
                          style: TextStyle(
                              color: Colors.black, fontFamily: "MaruBuri"),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
