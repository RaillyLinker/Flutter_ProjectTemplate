// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

// (all)
import '../../../../pages/all/all_page_home/page_widget.dart' as all_page_home;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (페이지 외곽 프레임)
class SlwPageOuterFrame extends StatelessWidget {
  const SlwPageOuterFrame(
      {super.key,
      required this.business,
      required this.child,
      this.floatingActionButton,
      required this.pageTitle,
      this.backgroundColor = Colors.white});

  // [public 변수]
  final SlwPageOuterFrameBusiness business;

  // !!!외부 입력 변수 선언 하기!!!
  // (하위 위젯)
  final Widget child;

  // (플로팅 버튼)
  final FloatingActionButton? floatingActionButton;

  // (페이지 타이틀)
  final String pageTitle;

  // (페이지 배경색을 파란색으로 할지 여부)
  final Color backgroundColor;

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return widgetUiBuild(context: context);
  }

  // [화면 작성]
  Widget widgetUiBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: !kIsWeb,
            title: Row(
              children: [
                HomeIconButton(
                  globalKey: business.goToHomeIconButtonGk,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text(
                  pageTitle,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "MaruBuri"),
                ))
              ],
            ),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        body: child);
  }
}

class SlwPageOuterFrameBusiness {
  // [콜백 함수]

  // [public 변수]
  // (goToHomeIconButtonBusiness)
  final GlobalKey<HomeIconButtonState> goToHomeIconButtonGk = GlobalKey();

// [private 변수]

// [public 함수]

// [private 함수]
}

// (홈 아이콘 버튼)
class HomeIconButton extends StatefulWidget {
  const HomeIconButton({required this.globalKey}) : super(key: globalKey);

  // [콜백 함수]
  @override
  HomeIconButtonState createState() => HomeIconButtonState();

  // [public 변수]
  final GlobalKey<HomeIconButtonState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required HomeIconButtonState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return ClipOval(
      child: MouseRegion(
        // 커서 변경 및 호버링 상태 변경
        cursor: SystemMouseCursors.click,
        onEnter: (details) {
          currentState.isHovering = true;
          currentState.refreshUi();
        },
        onExit: (details) {
          currentState.isHovering = false;
          currentState.refreshUi();
        },
        child: Tooltip(
          message: "홈으로",
          child: GestureDetector(
            // 클릭시 제스쳐 콜백
            onTap: () {
              context.goNamed(all_page_home.pageName);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 보여줄 위젯
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image(
                    image:
                        const AssetImage("lib/assets/images/app_logo_img.png"),
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
                // 호버링시 가릴 위젯(보여줄 위젯과 동일한 사이즈를 준비)
                Opacity(
                  opacity: currentState.isHovering ? 1.0 : 0.0,
                  // 0.0: 완전 투명, 1.0: 완전 불투명
                  child: Container(
                      width: 35,
                      height: 35,
                      color: Colors.blue.withOpacity(0.5),
                      child: const Icon(Icons.home)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeIconButtonState extends State<HomeIconButton> {
  HomeIconButtonState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 변수]
  // (위젯 호버링 여부)
  bool isHovering = false;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}
