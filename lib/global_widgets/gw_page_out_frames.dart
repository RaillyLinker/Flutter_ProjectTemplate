// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

// (all)
import '../../../pages/all/all_page_home/page_entrance.dart' as all_page_home;

// [페이지의 외곽 프레임 위젯 작성 파일]
// 전역의 페이지에서 사용 가능한 위젯입니다.
// View 에 해당하며, Business Logic 생성자에 콜백 함수 파라미터를 넣어주어 처리하세요.

//------------------------------------------------------------------------------
// (페이지 최외곽 프레임 템플릿)
class PageOutFrame extends StatelessWidget {
  const PageOutFrame(
    this.viewModel,
    this.child, {
    super.key,
    this.floatingActionButton,
  });

  final PageOutFrameViewModel viewModel;

  // 프레임 위젯 child
  final Widget child;

  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    GlobalKey<GoToHomeIconButtonState> goToHomeIconButtonStateGk = GlobalKey();

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: !kIsWeb,
            title: Row(
              children: [
                GoToHomeIconButton(viewModel.goToHomeIconButtonViewModel,
                    key: goToHomeIconButtonStateGk),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text(
                  viewModel.pageTitle,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "MaruBuri"),
                ))
              ],
            ),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor: viewModel.isPageBackgroundBlue
            ? Colors.blue
            : const Color(0xFFFFFFFF),
        floatingActionButton: floatingActionButton,
        body: child);
  }
}

class PageOutFrameViewModel {
  PageOutFrameViewModel(this.pageTitle, {this.isPageBackgroundBlue = false});

  // !!!위젯 에서 사용할 상태 변수 선언!!!
  // 주로 여기선 BLoC 에서 사용할 변수를 선언하고,
  // 가독성을 위하여 Stateless 위젯에서 사용하는 변수는 해당 변수의 파라미터로 설정하세요.

  // 페이지 배경색을 파란색으로 할지 여부
  final bool isPageBackgroundBlue;

  // 페이지 타이틀
  final String pageTitle;

  final GoToHomeIconButtonViewModel goToHomeIconButtonViewModel =
      GoToHomeIconButtonViewModel();
}

// (아이콘 버튼)
class GoToHomeIconButton extends StatefulWidget {
  const GoToHomeIconButton(this.viewModel, {required super.key});

  // 위젯 뷰모델
  final GoToHomeIconButtonViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  GoToHomeIconButtonState createState() => GoToHomeIconButtonState();
}

class GoToHomeIconButtonViewModel {
  GoToHomeIconButtonViewModel();

  // !!!위젯 상태 변수 선언하기!!!
  bool isHovering = false;
}

class GoToHomeIconButtonState extends State<GoToHomeIconButton> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return ClipOval(
      child: MouseRegion(
        // 커서 변경 및 호버링 상태 변경
        cursor: SystemMouseCursors.click,
        onEnter: (details) {
          widget.viewModel.isHovering = true;
          refresh();
        },
        onExit: (details) {
          widget.viewModel.isHovering = false;
          refresh();
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
                  opacity: widget.viewModel.isHovering ? 1.0 : 0.0,
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
