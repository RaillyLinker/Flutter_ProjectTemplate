// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

// (all)
import 'package:flutter_project_template/pages/all/all_page_home/main_widget.dart'
    as all_page_home;

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

  //----------------------------------------------------------------------------
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    business.context = context;
    return business.getScreenWidget(widget: this);
  }
}

class SlwPageOuterFrameBusiness {
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  // (goToHomeIconButtonBusiness)
  final GlobalKey<HomeIconButtonState> goToHomeIconButtonGk = GlobalKey();

  // (context 객체) - 처음 위젯이 build 되기 전에는 null, 이후는 not null
  BuildContext? context;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
  // [public 함수]

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required SlwPageOuterFrame widget}) {
    // !!!위젯 화면을 작성 하세요.!!!

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
                  key: goToHomeIconButtonGk,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text(
                  widget.pageTitle,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "MaruBuri"),
                ))
              ],
            ),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor: widget.backgroundColor,
        floatingActionButton: widget.floatingActionButton,
        body: widget.child);
  }
}

////
// (홈 아이콘 버튼)
class HomeIconButton extends StatefulWidget {
  const HomeIconButton({required super.key});

  // !!!외부 입력 변수 선언 하기!!!

  // [콜백 함수]
  @override
  HomeIconButtonState createState() => HomeIconButtonState();
}

class HomeIconButtonState extends State<HomeIconButton> {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget();
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

  //----------------------------------------------------------------------------
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  // (위젯 호버링 여부)
  bool isHovering = false;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!위젯 화면을 작성 하세요.!!!

    return ClipOval(
      child: MouseRegion(
        // 커서 변경 및 호버링 상태 변경
        cursor: SystemMouseCursors.click,
        onEnter: (details) {
          isHovering = true;
          refreshUi();
        },
        onExit: (details) {
          isHovering = false;
          refreshUi();
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
                  opacity: isHovering ? 1.0 : 0.0,
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

// (에러 페이지)
class ErrorPageWidget extends StatelessWidget {
  const ErrorPageWidget({
    super.key,
    required this.business,
    required this.errorMsg,
  });

  final ErrorPageWidgetBusiness business;

  // !!!외부 입력 변수 선언 하기!!!
  final String errorMsg;

  //----------------------------------------------------------------------------
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    business.context = context;
    return business.getScreenWidget(widget: this);
  }
}

class ErrorPageWidgetBusiness {
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  // (context 객체) - 처음 위젯이 build 되기 전에는 null, 이후는 not null
  late BuildContext context;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
  // [public 함수]

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required ErrorPageWidget widget}) {
    // !!!위젯 화면을 작성 하세요.!!!

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: !kIsWeb,
          title: const Text(
            "에러",
            style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
          ),
          backgroundColor: Colors.blue,
          iconTheme:
              const IconThemeData(color: Colors.white //change your color here
                  )),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.errorMsg,
              style:
                  const TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.goNamed(all_page_home.pageName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.blue)),
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text("홈으로",
                      style: TextStyle(
                          color: Colors.blue, fontFamily: "MaruBuri")),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
