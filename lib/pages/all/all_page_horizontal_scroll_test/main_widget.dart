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
const pageName = "all_page_horizontal_scroll_test";

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
    return PopScope(
      canPop: mainBusiness.canPop,
      child: FocusDetector(
        onFocusGained: () async {
          if (mainBusiness.needInitState) {
            mainBusiness.needInitState = false;
            await mainBusiness.onCreateWidget();
          }
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
        child: getScreenWidget(context: context),
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
  Widget getScreenWidget({required BuildContext context}) {
    // !!!화면 위젯 작성 하기!!!

    if (mainBusiness.inputError == true) {
      // 입력값이 미충족 되었을 때의 화면
      return const Center(
        child: Text(
          "잘못된 접근입니다.",
          style: TextStyle(color: Colors.red, fontFamily: "MaruBuri"),
        ),
      );
    }

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: mainBusiness.pageOutFrameBusiness,
      pageTitle: "가로 스크롤 테스트",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}